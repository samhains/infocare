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
    # total capacity 35
    # o2 capacity 15
    # u2 capacity 20

    # total used 23
    # o2 used 13
    # u2 used 10

    availabilities = Repo.all(Availability)
    first_availability = availabilities |> List.first

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

  test "updates availability for the room if details change" do
    prepare_db ServiceFixtures.service_1
    InfoCare.UpdateAvailabilities.run(~N[2016-07-04 00:00:00])
    ic_booking_id = "136743"
    booking = Repo.one(from b in Booking, where: b.ic_booking_id == ^ic_booking_id)
    booking = Ecto.Changeset.change booking, over_2: false
    Repo.update!(booking)

    InfoCare.UpdateAvailabilities.run(~N[2016-07-04 00:00:00])
    availabilities = Repo.all(Availability)
    first_availability = availabilities |> List.first

    assert first_availability.over_2 == 3
    assert first_availability.under_2 == 9
    assert first_availability.total == 12
    assert length(availabilities) == 14
  end
end
