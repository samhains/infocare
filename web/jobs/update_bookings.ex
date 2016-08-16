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
          |> Enum.map(&save_booking/1)
        {:ok, saved_bookings}
      {:error, error} ->
        Logger.error (inspect error.reason)
        {:error, error}
    end

  end
end
