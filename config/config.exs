# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :shortly,
  ecto_repos: [Shortly.Repo]

# Configures the endpoint
config :shortly, ShortlyWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "p36HXyaJRlzdpemw33aceU74l7VIWwg/vyr+K7wFxdLcIRRYZ6MigfNmemsL9K48",
  render_errors: [view: ShortlyWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Shortly.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :phoenix, :template_engines,
  slim: PhoenixSlime.Engine,
  slime: PhoenixSlime.Engine

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.

config :shortly,
  http_auth_config: [
    username: "admin",
    password: "pass",
    realm: "Admin Area"
  ]

config :shortly, base_url: "http://localhost:4000"

import_config "#{Mix.env()}.exs"
