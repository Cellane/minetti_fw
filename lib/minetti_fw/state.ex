defmodule MinettiFw.State do
  @moduledoc """
  GenServer representing the desired state of the air conditioner.
  """
  use GenServer

  alias MinettiFw.Encoder
  alias MinettiFw.Infrared

  defstruct mode: :off,
            temperature: 23.5,
            fan_speed: :auto,
            on_timer: nil,
            off_timer: nil

  @valid_modes [:cool, :heat, :dry, :fan_only, :auto, :off]
  @type t :: %__MODULE__{
          mode: :cool | :heat | :dry | :fan_only | :auto | :off,
          temperature: float(),
          fan_speed: :auto | :quiet | :low | :weak | :strong | :super,
          on_timer: nil | integer(),
          off_timer: nil | integer()
        }

  # Client
  def start_link(_), do: GenServer.start_link(__MODULE__, %__MODULE__{}, name: __MODULE__)

  def state, do: GenServer.call(__MODULE__, :state)

  def set_mode(mode) when mode in @valid_modes,
    do: GenServer.call(__MODULE__, {:set_mode, mode})

  def temperature_up, do: GenServer.call(__MODULE__, :temperature_up)
  def temperature_down, do: GenServer.call(__MODULE__, :temperature_down)
  def cycle_fan_speed, do: GenServer.call(__MODULE__, :cycle_fan_speed)

  def swing, do: GenServer.cast(__MODULE__, :swing)
  def vertical_direction, do: GenServer.cast(__MODULE__, :vertical_direction)

  # Server
  @impl GenServer
  def init(state), do: {:ok, state}

  @impl GenServer
  def handle_call(:state, _from, state), do: {:reply, state, state}

  def handle_call({:set_mode, mode}, _from, state) when mode in [:dry, :auto] do
    state = %__MODULE__{state | mode: mode, fan_speed: :auto}
    schedule_apply()
    {:reply, state, state}
  end

  def handle_call({:set_mode, mode}, _from, state) do
    state = %__MODULE__{state | mode: mode}
    schedule_apply()
    {:reply, state, state}
  end

  def handle_call(_command, _from, %__MODULE__{mode: :off} = state), do: {:reply, state, state}

  def handle_call(:temperature_up, _from, %__MODULE__{temperature: temperature} = state)
      when temperature >= 30,
      do: {:reply, state, state}

  def handle_call(:temperature_up, _from, %__MODULE__{temperature: temperature} = state) do
    state = %__MODULE__{state | temperature: temperature + 0.5}
    schedule_apply()
    {:reply, state, state}
  end

  def handle_call(:temperature_down, _from, %__MODULE__{temperature: temperature} = state)
      when temperature <= 16,
      do: {:reply, state, state}

  def handle_call(:temperature_down, _from, %__MODULE__{temperature: temperature} = state) do
    state = %__MODULE__{state | temperature: temperature - 0.5}
    schedule_apply()
    {:reply, state, state}
  end

  def handle_call(:cycle_fan_speed, _from, %{mode: mode} = state) when mode in [:dry, :auto],
    do: {:reply, state, state}

  def handle_call(:cycle_fan_speed, _from, %{fan_speed: fan_speed} = state) do
    state = %{state | fan_speed: next_fan_speed(fan_speed)}
    schedule_apply()
    {:reply, state, state}
  end

  @impl GenServer
  def handle_cast(:swing, state) do
    schedule_apply_special(:swing)
    {:noreply, state}
  end

  def handle_cast(:vertical_direction, state) do
    schedule_apply_special(:vertical_direction)
    {:noreply, state}
  end

  @impl GenServer
  def handle_info(:apply, state) do
    state
    |> broadcast()
    |> Encoder.encode()
    |> Infrared.blast()

    {:noreply, state}
  end

  def handle_info({:apply_special, command}, state) do
    command
    |> Encoder.encode()
    |> Infrared.blast()

    {:noreply, state}
  end

  defp broadcast(state) do
    Phoenix.PubSub.broadcast(MinettiUi.PubSub, "state", {:state_changed, state})
    state
  end

  defp fan_speed_order, do: [:auto, :quiet, :low, :weak, :strong, :super]

  defp next_fan_speed(current_speed),
    do:
      fan_speed_order()
      |> Stream.cycle()
      |> Stream.drop_while(&(&1 != current_speed))
      |> Enum.at(1)

  defp schedule_apply, do: send(self(), :apply)
  defp schedule_apply_special(command), do: send(self(), {:apply_special, command})
end
