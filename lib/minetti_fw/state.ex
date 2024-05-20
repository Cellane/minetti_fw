defmodule MinettiFw.State do
  @moduledoc """
  Struct module representing the desired state of the air conditioner.
  """
  defstruct mode: :cool,
            temperature: 23.5,
            fan_speed: :auto,
            on_timer: nil,
            off_timer: nil

  @type t :: %__MODULE__{
          mode: :cool | :heat | :dry | :fan_only | :auto,
          temperature: float(),
          fan_speed: :auto | :quiet | :low | :weak | :strong | :super,
          on_timer: nil | integer(),
          off_timer: nil | integer()
        }

  def set_mode(state, mode) when mode in [:dry, :auto],
    do: %__MODULE__{state | mode: mode, fan_speed: :auto}

  def set_mode(state, mode), do: %__MODULE__{state | mode: mode}

  def temperature_up(%__MODULE__{temperature: temperature} = state) when temperature >= 30,
    do: state

  def temperature_up(%__MODULE__{temperature: temperature} = state),
    do: %__MODULE__{state | temperature: temperature + 0.5}

  def temperature_down(%__MODULE__{temperature: temperature} = state) when temperature <= 16,
    do: state

  def temperature_down(%__MODULE__{temperature: temperature} = state),
    do: %__MODULE__{state | temperature: temperature - 0.5}
end
