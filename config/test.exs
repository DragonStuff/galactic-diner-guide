import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :galactic_diner_guide, GalacticDinerGuide.Repo,
  username: "galactic_access",
  password: "galactic_pass",
  hostname: "galactic_db",
  database: "galactic_diner_guide_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  timeout: 240_000,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :galactic_diner_guide, GalacticDinerGuideWeb.Endpoint,
  http: [ip: {0, 0, 0, 0}, port: 4002],
  secret_key_base: "AqLwSX4wjBXpXJcr7neEaH8hD1b186ZduMIf9F3xyaqY4i8xmuyceeB+zy5iXacw",
  server: false

# In test we don't send emails.
config :galactic_diner_guide, GalacticDinerGuide.Mailer, adapter: Swoosh.Adapters.Test

# Disable swoosh api client as it is only required for production adapters.
config :swoosh, :api_client, false

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
