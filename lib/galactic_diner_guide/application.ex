defmodule GalacticDinerGuide.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      GalacticDinerGuideWeb.Telemetry,
      # Start the Ecto repository
      GalacticDinerGuide.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: GalacticDinerGuide.PubSub},
      # Start Finch
      {Finch, name: GalacticDinerGuide.Finch},
      # Start the Endpoint (http/https)
      GalacticDinerGuideWeb.Endpoint
      # Start a worker by calling: GalacticDinerGuide.Worker.start_link(arg)
      # {GalacticDinerGuide.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: GalacticDinerGuide.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    GalacticDinerGuideWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
