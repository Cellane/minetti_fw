defmodule MinettiFw.Encoder do
  @separator "S"
  @legacy_header "11000010"
  @modern_header "11010101"

  alias MinettiFw.State

  @type special :: :swing | :stop | :vertical_direction

  @spec encode(State.t() | special()) :: String.t()
  def encode(:swing) do
    payload_1 = "01101011"
    payload_2 = "11100000"

    code = [
      @separator,
      @legacy_header,
      invert(@legacy_header),
      payload_1,
      invert(payload_1),
      payload_2,
      invert(payload_2),
      @separator
    ]

    Enum.join(code ++ code)
  end

  def encode(:stop) do
    payload_1 = "01111011"
    payload_2 = "11100000"

    code = [
      @separator,
      @legacy_header,
      invert(@legacy_header),
      payload_1,
      invert(payload_1),
      payload_2,
      invert(payload_2),
      @separator
    ]

    Enum.join(code ++ code)
  end

  def encode(:vertical_direction) do
    payload_0 = "11001001"
    payload_1 = "11110101"
    payload_2 = "00101100"

    code = [
      @separator,
      payload_0,
      invert(payload_0),
      payload_1,
      invert(payload_1),
      payload_2,
      invert(payload_2),
      @separator
    ]

    Enum.join(code ++ code)
  end

  def encode(state) do
    payload_1 = encode_payload_1(state)
    payload_2 = encode_payload_2(state)

    legacy = [
      @separator,
      @legacy_header,
      invert(@legacy_header),
      payload_1,
      invert(payload_1),
      payload_2,
      invert(payload_2),
      @separator
    ]

    modern =
      Enum.map(
        [
          @modern_header,
          [encode_speed(state), encode_special_bit(state)],
          ["00", encode_half_degree(state), "00000"],
          ["000", encode_16_degrees(state), "00", encode_super_speed(state), "0"],
          ["000000", encode_cool_mode(state), "0"]
        ],
        fn
          byte when is_list(byte) -> Enum.join(byte)
          byte -> byte
        end
      )

    checksum = calculate_checksum(modern)
    modern = [@separator, modern, checksum, @separator]

    Enum.join(legacy ++ legacy ++ modern)
  end

  @spec encode_payload_1(State.t()) :: String.t()
  defp encode_payload_1(state),
    do: Enum.join([encode_speed_legacy(state), encode_off_timer(state), "1"])

  @spec encode_payload_2(State.t()) :: String.t()
  defp encode_payload_2(state),
    do: Enum.join([encode_temperature(state), encode_mode(state), encode_timer_rest(state)])

  @spec encode_speed_legacy(State.t()) :: String.t()
  defp encode_speed_legacy(%State{mode: mode}) when mode in [:dry, :auto], do: "000"
  defp encode_speed_legacy(%State{fan_speed: :auto}), do: "101"
  defp encode_speed_legacy(%State{fan_speed: :quiet}), do: "111"
  defp encode_speed_legacy(%State{fan_speed: :low}), do: "100"
  defp encode_speed_legacy(%State{fan_speed: :weak}), do: "010"
  defp encode_speed_legacy(%State{fan_speed: speed}) when speed in [:strong, :super], do: "001"

  @spec encode_off_timer(State.t()) :: String.t()
  # TODO: Implement the remaining cases
  defp encode_off_timer(%State{off_timer: nil}), do: "1111"

  @spec encode_temperature(State.t()) :: String.t()
  defp encode_temperature(%State{mode: :fan_only}), do: "1110"

  defp encode_temperature(%State{temperature: temperature}),
    do:
      Map.get(
        %{
          16 => "0000",
          17 => "0000",
          18 => "0001",
          19 => "0011",
          20 => "0010",
          21 => "0110",
          22 => "0111",
          23 => "0101",
          24 => "0100",
          25 => "1100",
          26 => "1101",
          27 => "1001",
          28 => "1000",
          29 => "1010",
          30 => "1011"
        },
        trunc(temperature)
      )

  @spec encode_mode(State.t()) :: String.t()
  defp encode_mode(%State{mode: :cool}), do: "00"
  defp encode_mode(%State{mode: :fan_only}), do: "01"
  defp encode_mode(%State{mode: :dry}), do: "01"
  defp encode_mode(%State{mode: :auto}), do: "10"
  defp encode_mode(%State{mode: :heat}), do: "11"

  @spec encode_timer_rest(State.t()) :: String.t()
  defp encode_timer_rest(%State{on_timer: on_timer}) when not is_nil(on_timer), do: "11"

  defp encode_timer_rest(%State{off_timer: off_timer}) when not is_nil(off_timer) do
    # TODO: Implement the off timer overflow
    "TODO"
  end

  defp encode_timer_rest(_state), do: "00"

  @spec encode_speed(State.t()) :: String.t()
  defp encode_speed(%State{fan_speed: :auto}), do: "011001"
  defp encode_speed(%State{fan_speed: :quiet}), do: "000000"
  defp encode_speed(%State{fan_speed: :low}), do: "001010"
  defp encode_speed(%State{fan_speed: :weak}), do: "001111"
  defp encode_speed(%State{fan_speed: :strong}), do: "010100"
  defp encode_speed(%State{fan_speed: :super}), do: "011001"

  @spec encode_special_bit(State.t()) :: String.t()
  defp encode_special_bit(%State{mode: mode}) when mode in [:dry, :auto], do: "01"
  defp encode_special_bit(%State{fan_speed: :auto}), do: "10"
  defp encode_special_bit(%State{fan_speed: :quiet}), do: "01"
  defp encode_special_bit(_state), do: "00"

  @spec encode_half_degree(State.t()) :: String.t()
  defp encode_half_degree(%State{temperature: temperature})
       when trunc(temperature) == temperature,
       do: "0"

  defp encode_half_degree(_state), do: "1"

  @spec encode_16_degrees(State.t()) :: String.t()
  defp encode_16_degrees(%State{temperature: temperature}) when trunc(temperature) == 16, do: "1"
  defp encode_16_degrees(_state), do: "0"

  @spec encode_super_speed(State.t()) :: String.t()
  defp encode_super_speed(%State{fan_speed: :super}), do: "1"
  defp encode_super_speed(_state), do: "0"

  @spec encode_cool_mode(State.t()) :: String.t()
  defp encode_cool_mode(%State{mode: :cool}), do: "1"
  defp encode_cool_mode(_state), do: "0"

  @spec calculate_checksum([String.t()]) :: String.t()
  defp calculate_checksum(data),
    do:
      data
      |> Enum.map(&Integer.parse(&1, 2))
      |> Enum.reduce(0, fn {value, _}, acc -> acc + value end)
      |> Integer.to_string(2)
      |> String.slice(-8, 8)

  @spec invert(String.t()) :: String.t()
  def invert(bitstring),
    do:
      bitstring
      |> String.graphemes()
      |> Enum.map(fn
        "0" -> 1
        "1" -> 0
      end)
      |> Enum.join()
end