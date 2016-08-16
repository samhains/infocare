defmodule InfoCare.UpdateBookings do
  require IEx
  use Timex
  alias InfoCare.Service
  alias InfoCare.Child
  alias InfoCare.Booking
  alias InfoCare.Repo
  alias InfoCare.Api
  alias InfoCare.BookingParser

  import InfoCare.JobsHelper
  import Ecto.Query

  require Logger

  def run do
    Repo.all(Service)
  # {"BookingID":"136892","ChildID":"742","ParentID":"5305","Date":"2016-07-14","StartTime":"07:00","EndTime":"12:40","Absent":"false"}
    |> Stream.map(&update_bookings_for_service/1)
    |> Stream.run
  end

  def save_booking booking do
    ic_booking_id = booking.ic_booking_id
    query = from b in Booking, where: b.ic_booking_id == ^ic_booking_id

    booking
    |> insert_or_update_record_and_print_errors(Booking, %Booking{}, query)
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
        |> Enum.map(fn(booking) ->
          date_string = Timex.format!(booking.date, "%FT%T", :strftime)
          room_id = booking.room_id |> to_string
          child_sync_id = booking.child_sync_id
          child = Repo.one(from c in Child, where: c.sync_id == ^child_sync_id, preload: [:services])

          services_changeset =
            child.services
            |> prepend_to_list_if_unique(service, :ic_booking_id)
            |> Enum.map(&Ecto.Changeset.change/1)

          Ecto.Changeset.change(child)
          |> Ecto.Changeset.put_assoc(:services, services_changeset)
          |> Repo.update
          |> response_handler

          # update child associations
          booking
          |> Map.delete(:child_sync_id)
          |> Map.put(:child_id, child.id)
          |> save_booking

        end)
        {:ok, saved_bookings}
      {:error, error} ->
        Logger.error (inspect error.reason)
        {:error, error}
    end

  end
end
