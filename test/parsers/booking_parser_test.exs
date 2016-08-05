defmodule InfoCare.BookingParserTest do
  use ExUnit.Case, async: false
  use InfoCare.ConnCase

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

    bookings_data = BookingMocks.valid_response_body
      |> Poison.decode!
    bookings_data_by_room_id = Repo.all(from r in Room)
      |> Enum.reduce(%{}, fn(room, total) -> Map.put(total, room.id, bookings_data[room.sync_id]) end)

    bookings = BookingParser.parse bookings_data_by_room_id, service

    test_booking =
      %{
        absent: false, child_sync_id: "62b71ab7-d305-e611-80cb-00155d02dd3b",
          date: ~N[2016-07-04 00:00:00], day_status: "1",
          end_time: ~N[2016-07-04 13:00:00], expiry_time: ~N[2016-07-04 13:00:00],
          permanent_booking: "true", reminder_time: ~N[2016-07-04 08:00:00],
          start_time: ~N[2016-07-04 12:00:00],
          utilisation: "1"
       }

    first_booking =
      bookings
      |> List.first
      # remove the service and room id's as these change from test to test
      |> Map.delete(:service_id)
      |> Map.delete(:room_id)

    assert Map.equal?(test_booking, first_booking)
  end
end
