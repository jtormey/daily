# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :daily,
  ecto_repos: [Daily.Repo]

# Configures the endpoint
config :daily, DailyWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "pKgydvx5TnfA8QoFumqmcB2hC1TBwpTAEP73h7eaxr/5YTzG30V3sqlqyxrO8biS",
  render_errors: [view: DailyWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Daily.PubSub, adapter: Phoenix.PubSub.PG2]

config :daily, Daily.Repo,
  migration_primary_key: [name: :id, type: :binary_id],
  migration_timestamps: [type: :utc_datetime]

config :daily, :pow,
  user: Daily.Users.User,
  repo: Daily.Repo,
  web_module: DailyWeb

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
