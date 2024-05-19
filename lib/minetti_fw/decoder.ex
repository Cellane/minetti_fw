defmodule MinettiFw.Decoder do
  @moduledoc """
  Helper module to decode IR signals from a remote control.

  Used to help understand the structure of a signal.
  """

  @doc """
  Waits up to 3 seconds for a signal to be received and decodes it into a CSV string.

  The signal is decoded using NEC protocol. The CSV string is a sequence of 0s and 1s
  representing the signal, with 'S' representing a space longer than 4000 microseconds.
  """
  @spec decode_to_csv() :: String.t()
  def decode_to_csv do
    {output, :timeout} = MuonTrap.cmd("/usr/bin/mode2", ["-m", "-d", "/dev/lirc1"], timeout: 3000)

    output
    |> String.split("\n")
    |> Enum.reject(&String.starts_with?(&1, "Warning"))
    |> Enum.flat_map(&String.split/1)
    |> Enum.map(&Integer.parse/1)
    |> Enum.map(&elem(&1, 0))
    |> Enum.chunk_every(2, 2, :discard)
    |> Enum.map(fn
      [_pulse, space] when space > 4000 -> "S"
      [_pulse, space] when space > 1000 -> "1"
      [_pulse, _space] -> "0"
    end)
    |> Enum.join(",")
  end
end
