use Mix.Config

# For development, we disable any cache and enable
# debugging and code reloading.
#
# The watchers configuration can be used to run external
# watchers to your application. For example, we use it
# with brunch.io to recompile .js and .css sources.
config :infocare, InfoCare.Endpoint,
  http: [port: 4000],
  debug_errors: true,
  server: false

# Do not include metadata nor timestamps in development logs
config :logger, :console, format: "[$level] $message\n"

# Set a higher stacktrace during development.
# Do not configure such in production as keeping
# and calculating stacktraces is usually expensive.
config :phoenix, :stacktrace_depth, 20

# Configure your database
config :infocare, InfoCare.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "ubuntu",
  password: "",
  database: "circle_test",
  hostname: "127.0.0.1",
  pool: Ecto.Adapters.SQL.Sandbox
