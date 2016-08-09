defmodule InfoCare.AvailabilityParser do
  alias InfoCare.Api
  alias InfoCare.Repo
  require Logger

  def parse bookings_api_map do

    for {room_id, room_bookings} <- bookings_api_map,
      is_map(room_bookings),
    {date_string, room_hash} <- room_bookings,
      date_string != "$id" do
        date = Timex.parse!(date_string, "%FT%T", :strftime)
        %{
          date: date,
          room_id: room_id,
          used: round(room_hash["UtilisedPlaces"]),
          capacity: round(room_hash["PlaceLimit"]),
          open: room_hash["RollOpenStatus"] == 0
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
          |> parse
        {:ok, data}
      {:error, error} ->
        Logger.error (inspect error.reason)
        {:error, error}
    end
  end
end
