defmodule InfoCare.BookingTest do
  require IEx
  use InfoCare.ModelCase

  alias InfoCare.Booking

  @valid_attrs %{qk_booking_id: "123asdasdf4", date: "2010-04-17 14:00:00", end_time: "2010-04-17 14:00:00", fee: 42, start_time: "2010-04-17 14:00:00"}
  @invalid_attrs %{}

  @tag :skip
  test "changeset with valid attributes" do
    changeset = Booking.changeset(%Booking{}, @valid_attrs)
    IO.inspect changeset.errors
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Booking.changeset(%Booking{}, @invalid_attrs)
    refute changeset.valid?
  end
end
