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

  defp prepare_db do
    service = ServiceFixtures.service_1 |> Repo.insert!
    bookings = Repo.insert_all Booking, BookingFixtures.bookings(service)

  end

  test "saves availabilities to database" do
    prepare_db

    InfoCare.UpdateAvailabilities.run(~N[2016-07-04 00:00:00])

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
