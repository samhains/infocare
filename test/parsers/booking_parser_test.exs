defmodule InfoCare.BookingParserTest do
  use ExUnit.Case, async: false
  use InfoCare.ConnCase

  require IEx

  alias InfoCare.BookingMocks
  alias InfoCare.BookingParser
  alias InfoCare.ServiceFixtures
  alias InfoCare.ChildFixtures
  alias InfoCare.RoomFixtures
  alias InfoCare.Room

  defp prepare_db do
    service = ServiceFixtures.service_1 |> Repo.insert!
    service |> RoomFixtures.room_1 |> Repo.insert!
    service |> RoomFixtures.room_2 |> Repo.insert!
  end

  test "returns list of bookings from api data and service array" do
    service = prepare_db

    bookings =
      BookingMocks.valid_response_body
      |> Poison.decode!
      |> BookingParser.parse(service)

    IO.inspect bookings
    test_booking =
      %{absent: false, date: ~N[2016-07-04 00:00:00],
        end_time: ~N[2016-07-04 12:40:00], ic_booking_id: "136743",
        ic_child_id: "672", ic_parent_id: "5253",
        start_time: ~N[2016-07-04 07:00:00]}

    first_booking =
      bookings
      |> List.first
      |> Map.delete(:service_id)

    assert Map.equal?(test_booking, first_booking)
    assert length(bookings) == 191
  end
end
