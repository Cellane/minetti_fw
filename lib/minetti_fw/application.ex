defmodule MinettiFw.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: MinettiFw.Supervisor, max_restarts: 100, max_seconds: 1]

    children =
      [
        # Children for all targets
        # Starts a worker by calling: MinettiFw.Worker.start_link(arg)
        # {MinettiFw.Worker, arg},
      ] ++ children(target())

    prepare_system(target())

    Supervisor.start_link(children, opts)
  end

  def prepare_system(:host) do
  end

  def prepare_system(_target) do
    File.mkdir_p("/var/run/lirc")
  end

  # List all child processes to be supervised
  def children(:host) do
    [
      # Children that only run on the host
      # Starts a worker by calling: MinettiFw.Worker.start_link(arg)
      # {MinettiFw.Worker, arg},
    ]
  end

  def children(_target) do
    [
      # Children for all targets except host
      # Starts a worker by calling: MinettiFw.Worker.start_link(arg)
      # {MinettiFw.Worker, arg},
      {MuonTrap.Daemon, ["lircd", ["--nodaemon"], [name: :lircd]]}
    ]
  end

  def target() do
    Application.get_env(:minetti_fw, :target)
  end
end
