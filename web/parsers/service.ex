defmodule InfoCare.ServiceParser do
  alias InfoCare.QkAp
  alias InfoCare.QkApi
  alias Ecto.Date
  alias InfoCare.Repo
  require Logger
  require IEx

  def all do
    case QkApi.get_services do
      {:ok, response} ->
        services = parse response
        {:ok, services}
      {:error, error} ->
        Logger.error (inspect error)
        {:error, error}
    end
  end

  def parse response do
    response
    |> Map.fetch!("value")
    |> Enum.map(&parse_service/1)
  end

  defp parse_service service_data do
    IEx.pry
    rooms_data = service_data["Rooms"]

    address_data = service_data["StreetAddress"]
    qk_service_id = service_data["service"] |> to_string

    time_zone =
      address_data["State"]
      |> calculate_time_zone

    rooms =
      rooms_data
      |> Enum.map(&parse_room/1)

    service =
      %{
        building: to_string(service_data["Building"]),
        post_code:  to_string(address_data["Postcode"]),
        time_zone: time_zone,
        rooms: rooms,
        state:  address_data["State"],
        street: to_string(address_data["Street"]),
        suburb:  address_data["Suburb"],
        qk_service_id: to_string(service_data["ServiceId"]),
        name: service_data["Name"],
        email: service_data["Email"],
        licensed_capacity: to_string(service_data["LicensedPlaces"]),
        phone_number: service_data["PhoneNumber"]
      }
  end

  defp parse_room room_data do
    %{
      qk_room_id: to_string(room_data["RollId"]),
      name: room_data["Name"],
      active: room_data["Active"],
      max_age: room_data["MaximumAge"],
      min_age: room_data["MinimumAge"]
    }
  end

  defp calculate_time_zone state do
    case state do
      "VIC" ->
        "Australia/Melbourne"
      "NSW" ->
        "Australia/Sydney"
      "QLD" ->
        "Australia/Brisbane"
      "SA" ->
        "Australia/Adelaide"
      "NT" ->
        "Australia/Darwin"
      "WA" ->
        "Australia/Perth"
      "ACT" ->
        "Australia/Sydney"
      _ ->
        "Australia/Sydney"
    end
  end
end
