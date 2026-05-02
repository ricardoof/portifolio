defmodule Portifolio.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      PortifolioWeb.Telemetry,
      {DNSCluster, query: Application.get_env(:portifolio, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Portifolio.PubSub},
      # Start a worker by calling: Portifolio.Worker.start_link(arg)
      # {Portifolio.Worker, arg},
      # Start to serve requests, typically the last entry
      PortifolioWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Portifolio.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    PortifolioWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
