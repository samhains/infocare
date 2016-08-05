defmodule InfoCare.BookingController do
  use InfoCare.Web, :controller

  alias InfoCare.{Repo, Booking}

  def index(conn, _params) do
    query = from b in Booking

    bookings = Repo.all(query)

    conn
    |> Plug.Conn.put_status(:ok)
    |> json(bookings)
  end
end
