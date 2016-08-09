defmodule InfoCare.BookingParser do
  alias InfoCare.Api
  alias InfoCare.Repo
  require Logger

  def parse bookings_api_map, service  do

    for {room_id, room_bookings} <- bookings_api_map,
        is_map(room_bookings),
        {date_string, room_hash} <- room_bookings,
        is_map(room_hash),
        {child_sync_id, booking_hash} <- room_hash["ChildSyncIdChildDateValueMap"],
        child_sync_id != "$id" do
          date = Timex.parse!(date_string, "%FT%T", :strftime)
          status = booking_hash["DayStatus"];

          %{
            date: date,
            room_id: room_id,
            utilisation: to_string(booking_hash["Utilisation"]),
            permanent_booking: to_string(booking_hash["PermanentBooking"]),
            absent: status == 2,
            service_id: service.id,
            child_sync_id: child_sync_id,
            start_time: Timex.shift(date, hours: 12, minutes: 0),
            end_time: Timex.shift(date, hours: 13, minutes: 0),
            day_status: to_string(status),
            expiry_time: Timex.shift(date, hours: 13, minutes: 0),
            reminder_time: Timex.shift(date, hours: 8, minutes: 0),
          }
      end
  end

  def by_service service, start_date, end_date do
    rooms = Repo.all Ecto.assoc(service, :rooms)

    case Api.get_bookings_for_service(service, start_date, end_date)  do
      {:ok, bookings_data} ->
        data =
          rooms
          |> Enum.reduce(%{}, fn(room, total) -> Map.put(total, room.id, bookings_data[room.sync_id]) end)
          |> parse(service)
        {:ok, data}
      {:error, error} ->
        Logger.error (inspect error.reason)
        {:error, error}
    end
  end
end
