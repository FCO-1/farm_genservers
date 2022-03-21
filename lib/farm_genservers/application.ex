defmodule FarmGenservers.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      FarmGenservers.Repo,
      # Start the Telemetry supervisor
      FarmGenserversWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: FarmGenservers.PubSub},
      # Start the Endpoint (http/https)
      FarmGenserversWeb.Endpoint,
      {DynamicSupervisor, [strategy: :one_for_one, name: FarmGenservers.DynamicSupervisorWs]},
      #{FarmGenservers.Gen1, name: FarmGenservers.Gen1},
      FarmGenservers.PubsubListener
      # Start a worker by calling: FarmGenservers.Worker.start_link(arg)
      # {FarmGenservers.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: FarmGenservers.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    FarmGenserversWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
