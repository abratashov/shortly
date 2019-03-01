use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :shortly, ShortlyWeb.Endpoint,
  http: [port: 4002],
  server: true

config :shortly, :sql_sandbox, true

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :shortly, Shortly.Repo,
  username: "postgres",
  password: "postgres",
  database: "shortly_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

config :shortly, base_url: "http://localhost:4002"
