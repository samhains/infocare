defmodule InfoCare.UpdateAvailabilitiessTest do
  use ExUnit.Case, async: false
  use InfoCare.ConnCase
  require IEx

  alias InfoCare.Availability
  alias InfoCare.BookingMocks
  alias InfoCare.Repo
  alias InfoCare.Api
  alias InfoCare.SharedMocks
  alias InfoCare.ServiceFixtures
  alias InfoCare.RoomFixtures
  alias InfoCare.Room
  alias InfoCare.Service

  import Mock
  import Ecto.Query

  @get_bookings_url "https://www.qkenhanced.com.au/Enhanced.KindyNow/v1/Bookings/GetAll?source=update&serviceIds=317913&databaseId=5012&startDate=2016-08-03&endDate=2016-08-17"

  defp prepare_db do
    service = ServiceFixtures.service_1 |> Repo.insert!
    service |> RoomFixtures.room_1 |> Repo.insert!
    service |> RoomFixtures.room_2 |> Repo.insert!
  end

  def room_1_id do
    room_1_sync_id = "c6265ed4-1471-e211-a3ad-5ef3fc0d484b"
    room_1 = Repo.one(from r in Room, where: r.sync_id == ^room_1_sync_id)
    room_1.id
  end

  def room_2_id do
    room_2_sync_id = "c5265ed4-1471-e211-a3ad-5ef3fc0d484b"
    room_2 = Repo.one(from r in Room, where: r.sync_id == ^room_2_sync_id)
    room_2.id
  end

  test "saves availabilities to database" do
    prepare_db

    with_mock HTTPoison, [get: fn(_url, _headers) -> {:ok, BookingMocks.valid_response} end] do

      service = Repo.one(from s in Service)
      HTTPoison.get(@get_bookings_url, [foo: :bar])

      InfoCare.UpdateAvailabilities.run
      availabilities = Repo.all(from a in Availability)
      availability_1 = availabilities |> List.first
      availability_3 = availabilities |> List.last
      assert length(availabilities) == 3
      assert availability_1.room_id == room_1_id
      assert availability_3.room_id == room_2_id
    end
  end

  # Having a problem with HTTPoison, it wont let me run HTTPoison.get/2. until now I cannot return an error from the request *shrugs*

  test "updates availability for the room if details change " do
    prepare_db
    with_mock HTTPoison, [get: fn(_url, _headers) -> {:ok, BookingMocks.valid_response} end] do
      HTTPoison.get(@get_bookings_url, [foo: :bar])
      InfoCare.UpdateAvailabilities.run
      assert Repo.one(from a in Availability, select: count("*")) == 3
      availability =  Repo.one(from a in Availability, where: a.room_id == ^room_1_id)
      assert !is_nil(availability)
      assert availability.used == 3
    end

    with_mock HTTPoison, [get: fn(_url, _headers) -> {:ok, BookingMocks.room_capacity_change_response} end] do
      HTTPoison.get(@get_bookings_url, [foo: :bar])
      InfoCare.UpdateAvailabilities.run
      availability =  Repo.one(from a in Availability, where: a.room_id == ^room_1_id)

      assert !is_nil(availability)
      assert availability.used == 1
    end
  end
end
