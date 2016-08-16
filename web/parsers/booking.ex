defmodule InfoCare.BookingParser do
  alias InfoCare.Api
  alias InfoCare.Repo
  require Logger
  require IEx

  def parse bookings_api_map, service do
    bookings_api_map
    |> Map.fetch!("Bookings")
    |> Enum.map(fn (booking) -> parse_booking(booking, service) end)
  end

  def parse_booking booking_map, service do
    date_string = booking_map["Date"]
    date = Timex.parse!(date_string, "%F", :strftime)
    start_time_string = date_string <> booking_map["StartTime"]
    end_time_string = date_string <>booking_map["EndTime"]

    start_time = Timex.parse!(start_time_string, "%F%H:%M", :strftime)
    end_time = Timex.parse!(end_time_string, "%F%H:%M", :strftime)

    %{
      ic_booking_id: booking_map["BookingID"],
      absent:  String.to_existing_atom(booking_map["Absent"]),
      ic_child_id: booking_map["ChildID"],
      ic_parent_id: booking_map["ParentID"],
      service_id: service.id,
      date: date,
      start_time: start_time,
      end_time: end_time
    }
  end

  def by_service service, start_date, end_date do
    case Api.get_bookings_by_service(service, start_date, end_date)  do
      {:ok, bookings_data} ->
        bookings =
          parse(bookings_data, service)
        {:ok, bookings}
      {:error, error} ->
        Logger.error (inspect error.reason)
        {:error, error}
    end
  end
end
