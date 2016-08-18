defmodule InfoCare.UpdateAvailabilitiessTest do
  use ExUnit.Case, async: false
  use InfoCare.ConnCase
  require IEx

  alias InfoCare.Availability
  alias InfoCare.BookingMocks
  alias InfoCare.Repo
  alias InfoCare.Api
  alias InfoCare.Booking
  alias InfoCare.SharedMocks
  alias InfoCare.ServiceFixtures
  alias InfoCare.BookingFixtures
  alias InfoCare.Room
  alias InfoCare.Service

  import Mock
  import Ecto.Query

  @get_bookings_url "mock.url"

  defp prepare_db service do
    service = service |> Repo.insert!
    bookings = Repo.insert_all Booking, BookingFixtures.bookings(service)

  end

  test "saves availabilities to database" do
    prepare_db ServiceFixtures.service_1
    InfoCare.UpdateAvailabilities.run(~N[2016-07-04 00:00:00])
    availabilities = Repo.all(Availability)
    first_availability = availabilities |> List.first

    # total capacity 35
    # o2 capacity 15
    # u2 capacity 20

    # total used 23
    # o2 used 13
    # u2 used 10

    assert first_availability.over_2 == 2
    assert first_availability.under_2 == 10
    assert first_availability.total == 12
    assert length(availabilities) == 14
  end

  test "over_2 and under_2 availabilities zero when total is zero" do
    prepare_db ServiceFixtures.service_2
    InfoCare.UpdateAvailabilities.run(~N[2016-07-04 00:00:00])
    availabilities = Repo.all(Availability)
    first_availability = availabilities |> List.first

    assert first_availability.total == 0
    assert first_availability.over_2 == 0
    assert first_availability.under_2 == 0
    assert length(availabilities) == 14
  end

  # test "updates availability for the room if details change " do
  #   prepare_db
  #   with_mock HTTPoison, [get: fn(_url, _headers) -> {:ok, BookingMocks.valid_response} end] do
  #     HTTPoison.get(@get_bookings_url, [foo: :bar])
  #     InfoCare.UpdateAvailabilities.run
  #     assert Repo.one(from a in Availability, select: count("*")) == 3
  #     availability =  Repo.one(from a in Availability, where: a.room_id == ^room_1_id)
  #     assert !is_nil(availability)
  #     assert availability.used == 3
  #   end

  #   with_mock HTTPoison, [get: fn(_url, _headers) -> {:ok, BookingMocks.room_capacity_change_response} end] do
  #     HTTPoison.get(@get_bookings_url, [foo: :bar])
  #     InfoCare.UpdateAvailabilities.run
  #     availability =  Repo.one(from a in Availability, where: a.room_id == ^room_1_id)

  #     assert !is_nil(availability)
  #     assert availability.used == 1
  #   end
  # end
end
