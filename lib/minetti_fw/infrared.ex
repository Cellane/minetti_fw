defmodule MinettiFw.Infrared do
  @moduledoc """
  Module which takes a string representing binary ones and zeros (& signal separators)
  and blasts it.
  """

  @short 530
  @long 1610
  @very_long 4400

  @spec blast(String.t(), String.t()) ::
          :ok | {:error, File.posix_error()} | {:error, pos_integer()}
  def blast(signal, path \\ "/etc/lirc/lircd.conf.d/MinettiRemote.lircd.conf") do
    body =
      signal
      |> String.graphemes()
      |> Enum.flat_map(fn
        "S" -> [@very_long, @very_long]
        "T" -> [@short, @very_long]
        "1" -> [@short, @long]
        "0" -> [@short, @short]
      end)
      |> Enum.slice(0..-2)
      |> Enum.map(&Integer.to_string/1)
      |> Enum.map(&String.pad_leading(&1, 9))
      |> Enum.chunk_every(6)
      |> Enum.map(&Enum.join/1)
      |> Enum.join("\n")
      |> Kernel.<>("\n")

    contents = Enum.join([header(), body, footer()])

    with :ok <- File.write(path, contents),
         true <- reload_lircd(),
         :ok <- Process.sleep(500),
         {_output, 0} <-
           System.cmd("irsend", ["SEND_ONCE", "MinettiRemote", "fire"], stderr_to_stdout: true) do
      :ok
    else
      {:error, reason} -> {:error, reason}
      {output, exit_code} -> {:error, {exit_code, output}}
    end
  end

  @spec header() :: String.t()
  defp header,
    do: """
    begin remote
      name  MinettiRemote
      flags RAW_CODES
      eps   30
      aeps  100

      ptrail 0
      repeat 0 0
      gap 28205

      begin raw_codes
        name fire
    """

  @spec footer() :: String.t()
  defp footer,
    do: """
      end raw_codes
    end remote
    """

  @spec reload_lircd() :: boolean()
  defp reload_lircd,
    do:
      :lircd
      |> Process.whereis()
      |> Process.exit(:reload)
end
