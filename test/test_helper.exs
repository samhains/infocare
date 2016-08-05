ExUnit.start(exclude: [:skip])

Ecto.Adapters.SQL.Sandbox.mode(InfoCare.Repo, {:shared, self()})
