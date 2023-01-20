import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :business_intelligence, BusinessIntelligence.Repo,
  database: Path.expand("../business_intelligence_test.db", Path.dirname(__ENV__.file)),
  pool_size: 5,
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :business_intelligence, BusinessIntelligenceWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "MoqeyAL8g+aEQFylDb1370AR1PUcvKrDYUQvvx13CaPxwUIDHdYB5+IA7L/oQEBJ",
  server: false

# In test we don't send emails.
config :business_intelligence, BusinessIntelligence.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :debug

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
