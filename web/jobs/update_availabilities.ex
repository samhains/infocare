defmodule InfoCare.UpdateAvailabilities do
  use Timex
  alias InfoCare.Availability
  alias InfoCare.Service
  alias InfoCare.Booking
  alias InfoCare.AvailabilityParser
  alias InfoCare.Repo
  require IEx

  import InfoCare.JobsHelper
  import Ecto.Query

  require Logger

  def run date do
    Repo.all(Service)
    |> Stream.map(fn (service) -> update_availabilities_for_service(date, service) end)
    |> Stream.run
  end

  def save_availability availability do
    date = availability.date
    service_id = availability.service_id
    query = from a in Availability, where: [date: type(^availability.date, Timex.Ecto.DateTime), service_id: ^service_id]

    availability
    |> insert_or_update_record_and_print_errors(Availability, %Availability{}, query)
  end

  defp shift_date_by_num start_date, num do
    start_date
    |> Timex.shift(days: num)
  end

  def update_availabilities_for_service date, service do

    date_list =
      for(n <- 0..13, do: n)
      |> Enum.map(fn (num) -> shift_date_by_num(date, num) end)
      |> Enum.map(fn(end_date)->

        all = Repo.one(from b in Booking, select: count("*"))
        total = Repo.one(from b in Booking, select: count("*"), where: [date: ^end_date])
        over_2 = Repo.one(from b in Booking, select: count("*"), where: [date: ^end_date, over_2: true])
        under_2 = Repo.one(from b in Booking, select: count("*"), where: [date: ^end_date, over_2: false])

        availability =
          %{
            :total => total,
            :date => end_date,
            :over_2 => over_2,
            :under_2 => under_2,
            :service_id => service.id
          }
          |> save_availability
      end)
  end
end
