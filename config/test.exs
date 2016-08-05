use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :kindy_now_qk, InfoCare.Endpoint,
  http: [port: 4001],
  debug_errors: true,
  server: false

# Print only warnings and errors during test
config :logger, :info, format: "[$level] $message\n"
# Set a higher stacktrace during development.
# Do not configure such in production as keeping
# and calculating stacktraces is usually expensive.
config :phoenix, :stacktrace_depth, 20

# Configure your database
config :kindy_now_qk, InfoCare.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "kindy_now_qk_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
