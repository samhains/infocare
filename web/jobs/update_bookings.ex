defmodule InfoCare.UpdateBookings do
  require IEx
  use Timex
  alias InfoCare.Service
  alias InfoCare.Child
  alias InfoCare.Parent
  alias InfoCare.Booking
  alias InfoCare.Repo
  alias InfoCare.Api
  alias InfoCare.BookingParser

  import InfoCare.JobsHelper
  import Ecto.Query

  require Logger

  def run do
    Repo.all(Service)
    |> Stream.map(&update_bookings_for_service/1)
    |> Stream.run
  end

  def save_booking booking do
    ic_booking_id = booking.ic_booking_id
    query = from b in Booking, where: b.ic_booking_id == ^ic_booking_id

    booking
    |> Map.delete(:ic_child_id)
    |> Map.delete(:ic_parent_id)
    |> insert_or_update_record_and_print_errors(Booking, %Booking{}, query)
  end

  def associate_child(booking) do
    ic_child_id = booking.ic_child_id
    child = Repo.one(from c in Child, where: c.ic_child_id == ^ic_child_id)
    child_id = if child, do: child.id
    booking |> Map.put(:child_id, child_id)
  end

  def associate_parent(booking) do
    ic_parent_id = booking.ic_parent_id
    parent = Repo.one(from c in Parent, where: c.ic_parent_id == ^ic_parent_id)
    parent_id = if parent, do: parent.id
    booking |> Map.put(:parent_id, parent_id)
  end

  def update_bookings_for_service service do

    {:ok, start_date} =
      Timex.now
      |> Timex.format("%F", :strftime)

    {:ok, end_date} =
      Timex.now
      |> Timex.shift(days: 14)
      |> Timex.format("%F", :strftime)

    case BookingParser.by_service(service, start_date, end_date)  do
      {:ok, bookings} ->
        saved_bookings =
          bookings
          |> Enum.map(fn (booking) ->
              booking
              |> associate_child
              |> associate_parent
              |> save_booking
            end)
        {:ok, saved_bookings}
      {:error, error} ->
        Logger.error (inspect error.reason)
        {:error, error}
    end

  end
end
