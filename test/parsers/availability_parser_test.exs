defmodule InfoCare.AvailabilityParserTest do
  use ExUnit.Case, async: false
  use InfoCare.ConnCase

  alias InfoCare.BookingMocks
  alias InfoCare.AvailabilityParser
  alias InfoCare.ServiceFixtures
  alias InfoCare.RoomFixtures
  alias InfoCare.Room

  defp prepare_db do
    service = ServiceFixtures.service_1 |> Repo.insert!
  end


  # test "returns list of availabilities from api data and service list" do
  #   prepare_db

  #   bookings_data = BookingMocks.valid_response_body
  #     |> Poison.decode!
  #   test_availability = %{capacity: 8, date: ~N[2016-07-04 00:00:00], open: true, used: 3}

  #   availabilities =
  #     AvailabilityParser.parse(bookings_data_by_room_id)

  #   first_availability =
  #     availabilities
  #     |> List.first
  #     |> Map.delete(:room_id)

  #   assert length(availabilities) == 3
  #   assert Map.equal?(test_availability, first_availability)
  # end
end
