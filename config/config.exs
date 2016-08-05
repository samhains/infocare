# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :kindy_now_qk,
  ecto_repos: [InfoCare.Repo]

# Configures the endpoint
config :kindy_now_qk, InfoCare.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Yrc1uyQnEth2hD27kKcgJWzPQJOza9g+6EbTRehPOTT2AQ3joLrKgpFNTlQXU6Ou",
  render_errors: [view: InfoCare.ErrorView, accepts: ~w(html json)],
  pubsub: [name: InfoCare.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
