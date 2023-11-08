defmodule Dogtor.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      DogtorWeb.Telemetry,
      {DNSCluster, query: Application.get_env(:dogtor, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Dogtor.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Dogtor.Finch},
      # Start a worker by calling: Dogtor.Worker.start_link(arg)
      # {Dogtor.Worker, arg},
      # Start to serve requests, typically the last entry
      DogtorWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Dogtor.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    DogtorWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
