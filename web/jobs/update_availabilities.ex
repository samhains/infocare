defmodule InfoCare.UpdateAvailabilities do
  use Timex
  alias InfoCare.Availability
  alias InfoCare.Service
  alias InfoCare.AvailabilityParser
  alias InfoCare.Repo
  require IEx

  import InfoCare.JobsHelper
  import Ecto.Query

  require Logger

  def run do
    Repo.all(Service)
    |> Stream.map(&update_availabilities_for_service/1)
    |> Stream.run
  end

  def save_availability availability do
    date = availability.date
    room_id = availability.room_id
    query = from a in Availability, where: [date: type(^availability.date, Timex.Ecto.DateTime), room_id: ^room_id]

    availability
    |> insert_record_and_print_errors(Availability, %Availability{}, query)
  end

  def update_availabilities_for_service service do

    {:ok, start_date} =
      Timex.now
      |> Timex.format("%F", :strftime)

    {:ok, end_date} =
      Timex.now
      |> Timex.shift(days: 14)
      |> Timex.format("%F", :strftime)

    # get the bookings for the date range for the service

    case AvailabilityParser.by_service(service, start_date, end_date)  do
      {:ok, availabilities} ->
        data =
          availabilities
          |> Enum.map(&save_availability/1)
        {:ok, data}
      {:error, error} ->
        Logger.error (inspect error.reason)
        {:error, error}
    end
  end
end
