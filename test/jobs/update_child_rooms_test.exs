defmodule InfoCare.UpdateChildRoomsTest do
  use ExUnit.Case, async: false
  use InfoCare.ConnCase
  require IEx

  import Mock
  import Ecto.Query

  @get_bookings_url "mock.url"

  defp prepare_db service do
    service = service |> Repo.insert!
    bookings = Repo.insert_all Booking, BookingFixtures.bookings(service)
    service
  end

  test "saves child room associations" do
    prepare_db ServiceFixtures.service_1
    InfoCare.UpdateChildRooms.run(~N[2016-07-04 00:00:00])
  end
end
