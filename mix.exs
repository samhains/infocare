defmodule InfoCare.Mixfile do
  use Mix.Project

  def project do
    [app: :kindy_now_qk,
     version: "0.0.1",
     elixir: "~> 1.3.2",
     elixirc_paths: elixirc_paths(Mix.env),
     compilers: [:phoenix, :gettext] ++ Mix.compilers,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     aliases: aliases(),
     deps: deps(),
     dialyzer: [
                plt_apps: ["erts", "kernel", "stdlib", "crypto", "public_key", "mnesia"],
                flags: ["-Wunmatched_returns", "-Werror_handling", "-Wrace_conditions", "-Wno_opaque"],
                paths: ["_build/dev/lib/kindy_now_auth/ebin"]
              ]
   ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [mod: {InfoCare, []},
     applications: [:httpoison, :phoenix, :phoenix_pubsub, :phoenix_html, :cowboy, :logger, :gettext,
                    :phoenix_ecto, :postgrex, :timex_ecto, :parallel_stream]]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "web", "test/support", "test/fixtures", "test/mocks"]
  defp elixirc_paths(_),     do: ["lib", "web"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [{:phoenix, "~> 1.2.0"},
     {:timex, "~> 3.0"},
     {:timex_ecto, "~> 3.0"},
     {:parallel_stream, "~> 1.0.3"},
     {:phoenix_pubsub, "~> 1.0"},
     {:phoenix_ecto, "~> 3.0"},
     {:postgrex, ">= 0.0.0"},
     {:phoenix_html, "~> 2.6"},
     {:gettext, "~> 0.11"},
     {:cowboy, "~> 1.0"},
     {:httpoison, "~> 0.9.0"},

     # Dev & Test Dependencies
     {:phoenix_live_reload, "~> 1.0", only: :dev},
     {:mock, "~> 0.1.1", only: :test},
     {:credo, "~> 0.3", only: [:dev, :test]},
     {:dogma, "~> 0.1", only: [:dev]},
     {:dialyxir, "~> 0.3", only: [:dev]}]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to create, migrate and run the seeds file at once:
  #
  #     $ mix ecto.setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    ["ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
     "ecto.reset": ["ecto.drop", "ecto.setup"],
     "test": ["ecto.create --quiet", "ecto.migrate", "test"]]
  end
end
