use Mix.Config

config :shortly, ShortlyWeb.Endpoint, cache_static_manifest: "priv/static/cache_manifest.json"

config :logger, level: :info

config :shortly, base_url: "http://#{System.get_env("APP_NAME")}.gigalixirapp.com"
config :shortly, base_host: "#{System.get_env("APP_NAME")}.gigalixirapp.com"

config :shortly, ShortlyWeb.Endpoint,
  http: [:inet6, port: {:system, "PORT"}],
  url: [host: System.get_env("APP_NAME") <> ".gigalixirapp.com", port: 80],
  secret_key_base: Map.fetch!(System.get_env(), "SECRET_KEY_BASE"),
  server: true

config :shortly, Shortly.Repo,
  adapter: Ecto.Adapters.Postgres,
  url: System.get_env("DATABASE_URL"),
  ssl: true,
  pool_size: 2
