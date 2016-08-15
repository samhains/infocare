defmodule InfoCare.BookingParser do
  alias InfoCare.Api
  alias InfoCare.Repo
  require Logger
  require IEx

  # {"BookingID":"136892","ChildID":"742","ParentID":"5305","Date":"2016-07-14","StartTime":"07:00","EndTime":"12:40","Absent":"false"}
  def parse bookings_api_map do
    bookings_api_map
    |> Enum.map(&parse_booking/1)
  end

  def parse_booking booking_map do
    date_string = booking_map["Date"]
    date = Timex.parse!(date_string, "%F", :strftime)
    start_time_string = date_string <> booking_map["StartTime"]
    end_time_string = date_string <> booking_map["EndTime"]

    start_time = Timex.parse!(start_time_string, "%F%T", :strftime)
    end_time = Timex.parse!(start_time_string, "%F%T", :strftime)

    %{
      ic_booking_id: booking_map["BookingID"],
      ic_child_id: booking_map["BookingID"],
      date: date,
      start_time: start_time,
      end_time: end_time
    }
  end

  def by_service service, start_date, end_date do
    case Api.get_bookings_by_service(service, start_date, end_date)  do
      {:ok, bookings_data} ->
        bookings =
          parse(bookings_data)
        {:ok, bookings}
      {:error, error} ->
        Logger.error (inspect error.reason)
        {:error, error}
    end
  end
end
