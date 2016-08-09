defmodule InfoCare.UpdateBookings do
  require IEx
  use Timex
  alias InfoCare.Service
  alias InfoCare.Child
  alias InfoCare.Booking
  alias InfoCare.Repo
  alias InfoCare.QkApi
  alias InfoCare.BookingParser

  import InfoCare.JobsHelper
  import Ecto.Query

  require Logger

  def run do
    Repo.all(Service)
    |> Stream.map(&update_bookings_and_openings_for_service/1)
    |> Stream.run
  end

  def save_booking booking do
    qk_booking_id = booking.qk_booking_id
    query = from b in Booking, where: b.qk_booking_id == ^qk_booking_id

    booking
    |> insert_or_update_record_and_print_errors(Booking, %Booking{}, query)
  end

  def update_bookings_and_openings_for_service service do

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

          # create booking id here rather than in parser as it requires API request to get child
          qk_booking_id =  date_string <> ":" <> room_id <> ":" <> to_string(child.id)


          services_changeset =
            child.services
            |> prepend_to_list_if_unique(service, :qk_booking_id)
            |> Enum.map(&Ecto.Changeset.change/1)

          Ecto.Changeset.change(child)
          |> Ecto.Changeset.put_assoc(:services, services_changeset)
          |> Repo.update
          |> response_handler

          # update child associations
          booking
          |> Map.delete(:child_sync_id)
          |> Map.put(:child_id, child.id)
          |> Map.put(:qk_booking_id, qk_booking_id)
          |> save_booking

        end)
        {:ok, saved_bookings}
      {:error, error} ->
        Logger.error (inspect error.reason)
        {:error, error}
    end

  end
end
