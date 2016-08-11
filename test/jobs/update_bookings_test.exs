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
    service |> RoomFixtures.room_1 |> Repo.insert!
    service |> RoomFixtures.room_2 |> Repo.insert!
    ChildFixtures.child_1 |> Repo.insert!
    ChildFixtures.child_2 |> Repo.insert!
    ChildFixtures.child_3 |> Repo.insert!
    ChildFixtures.child_4 |> Repo.insert!
    ChildFixtures.child_5 |> Repo.insert!
    ChildFixtures.child_6 |> Repo.insert!
  end


  test "saves bookings to database" do
    prepare_db

    with_mock HTTPoison, [post: fn(_url,_body,  _headers) -> {:ok, BookingMocks.valid_response} end] do
      HTTPoison.post("https://www.qkenhanced.com.au/Enhanced.KindyNow/v1/Bookings/postAll?source=update&serviceIds=317913&databaseId=5012&startDate=2016-07-04&endDate=2016-07-18", [foo: :bar])

      InfoCare.UpdateBookings.run
      assert Repo.one(from b in Booking, select: count("*")) == 8
    end
  end

  test "updates the services and bookings associations for the child in question" do
    prepare_db
    with_mock HTTPoison, [post: fn(_url,_body,  _headers) -> {:ok, BookingMocks.valid_response} end] do
      HTTPoison.post("https://www.qkenhanced.com.au/Enhanced.KindyNow/v1/Bookings/postAll?source=update&serviceIds=317913&databaseId=5012&startDate=2016-07-04&endDate=2016-07-18", [foo: :bar])
      InfoCare.UpdateBookings.run
      ic_child_id = "1"
      child =  Repo.one(from c in Child, where: c.ic_child_id == ^ic_child_id, preload: [:bookings, :services])
      assert length(child.services) == 1
      assert length(child.bookings) == 2
    end
  end

  # test "will update booking information if it changes" do
  #   prepare_db
  #   with_mock HTTPoison, [post: fn(_url,_body,  _headers) -> {:ok, BookingMocks.valid_response} end] do
  #     HTTPoison.post("https://www.qkenhanced.com.au/Enhanced.KindyNow/v1/Bookings/postAll?source=update&serviceIds=317913&databaseId=5012&startDate=2016-07-04&endDate=2016-07-18", [foo: :bar])
  #     InfoCare.UpdateBookings.run
  #   end
  #   with_mock HTTPoison, [post: fn(_url,_body,  _headers) -> {:ok, BookingMocks.booking_change_response} end] do
  #     HTTPoison.post("https://www.qkenhanced.com.au/Enhanced.KindyNow/v1/Bookings/postAll?source=update&serviceIds=317913&databaseId=5012&startDate=2016-07-04&endDate=2016-07-18", [foo: :bar])
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
