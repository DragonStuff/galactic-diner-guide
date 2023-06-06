defmodule GalacticDinerGuide.Repo do
  use Ecto.Repo,
    otp_app: :galactic_diner_guide,
    adapter: Ecto.Adapters.Postgres
end
