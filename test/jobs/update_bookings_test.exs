defmodule InfoCare.UpdateBookingsTest do
  use ExUnit.Case, async: false
  use InfoCare.ConnCase

  alias InfoCare.Booking
  alias InfoCare.Availability
  alias InfoCare.BookingMocks
  alias InfoCare.Repo
  alias InfoCare.Child
  alias InfoCare.Service
  alias InfoCare.ServiceFixtures
  alias InfoCare.ChildFixtures
  alias InfoCare.RoomFixtures
  alias InfoCare.Room

  import Mock
  import Ecto.Query
  import IEx

  defp prepare_db do
    service = ServiceFixtures.service_1 |> Repo.insert!
    ChildFixtures.child_1(service) |> Repo.insert!
  end


  test "saves bookings to database" do
    prepare_db
    with_mock HTTPoison, [post: fn(_url, _headers) -> {:ok, BookingMocks.valid_response} end] do
      HTTPoison.post(@get_bookings_url, [foo: :bar])
      InfoCare.UpdateBookings.run
      assert Repo.one(from b in Booking, select: count("*")) == 191
    end
  end

  # TODO implement test for parent association

  test "booking is associated with service, parent and child" do
    prepare_db
    with_mock HTTPoison, [post: fn(_url, _headers) -> {:ok, BookingMocks.valid_response} end] do
      HTTPoison.post(@get_bookings_url, [foo: :bar])
      InfoCare.UpdateBookings.run

      ic_child_id = "672"
      child =  Repo.one(from c in Child, where: c.ic_child_id == ^ic_child_id, preload: [:bookings, :service])
      assert length(child.bookings) == 9

      ic_booking_id = "136743"
      booking =  Repo.one(from b in Booking, where: b.ic_booking_id == ^ic_booking_id, preload: [:service, :child])
      assert booking.child_id == child.id
      assert booking.service.ic_service_id == "317913"

    end
  end

  # test "will update booking information if it changes" do
  #   prepare_db
  #   with_mock HTTPoison, [post: fn(_url, _headers) -> {:ok, BookingMocks.valid_response} end] do
  #     HTTPoison.post(@get_bookings_url, [foo: :bar])
  #     InfoCare.UpdateBookings.run
  #   end
  #   with_mock HTTPoison, [post: fn(_url, _headers) -> {:ok, BookingMocks.booking_change_response} end] do
  #     HTTPoison.post(@get_bookings_url, [foo: :bar])
  #     InfoCare.UpdateBookings.run
  #     sync_id = "0f94ff68-ea49-e411-a741-5ef3fc0d484b"
  #     child =  Repo.one(from c in Child, where: c.sync_id == ^sync_id, preload: [:bookings])

  #     booking_1 = List.first child.bookings
  #     booking_2 = List.last child.bookings

  #     assert Repo.one(from c in Child, select: count("*")) == 6
  #     assert Repo.one(from b in Booking, select: count("*")) == 8
  #     assert booking_1.day_status == "2"
  #     assert booking_2.day_status == "2"
  #   end
  # end
end
