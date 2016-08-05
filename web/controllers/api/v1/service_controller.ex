defmodule InfoCare.ServiceController do
  use InfoCare.Web, :controller

  alias InfoCare.{Repo, Service}

  def index(conn, _params) do
    query = from s in Service,
      preload: :rooms

    services = Repo.all(query)

    conn
    |> Plug.Conn.put_status(:ok)
    |> json(services)
  end
end
