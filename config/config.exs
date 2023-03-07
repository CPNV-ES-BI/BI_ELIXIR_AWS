# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :business_intelligence,
  ecto_repos: [BusinessIntelligence.Repo],
  generators: [binary_id: true]

# Configures the endpoint
config :business_intelligence, BusinessIntelligenceWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: BusinessIntelligenceWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: BusinessIntelligence.PubSub,
  live_view: [signing_salt: "K0HfeFsv"]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :business_intelligence, BusinessIntelligence.Mailer, adapter: Swoosh.Adapters.Local

# Swoosh API client is needed for adapters other than SMTP.
config :swoosh, :api_client, false

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :ex_aws,
  access_key_id: [{:system, "AWS_ACCESS_KEY_ID"}, :instance_role],
  secret_access_key: [
    {:system, "AWS_SECRET_ACCESS_KEY"},
    :instance_role
  ]

config :ex_aws, :hackney_opts,
  follow_redirect: true,
  recv_timeout: 30_000

config :ex_aws,
  normalize_path: false,
  http_client: HTTPoison

# default values shown below
config :ex_aws, :retries,
  max_attempts: 10,
  base_backoff_in_ms: 10,
  max_backoff_in_ms: 10_000

if Mix.env() != :prod do
  config :git_hooks,
    mix_path: "docker-compose exec app mix",
    verbose: true,
    hooks: [
      pre_commit: [
        tasks: [
          {:cmd, "mix clean"},
          {:cmd, "mix compile --warnings-as-errors"},
          {:cmd, "mix format --check-formatted"},
          {:cmd, "mix credo --strict"},
          {:cmd, "mix dialyzer"},
          {:cmd, "mix espec", env: [{"MIX_ENV", "test"}]}
        ]
      ]
    ]
end

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
