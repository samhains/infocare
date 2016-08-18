defmodule InfoCare.ServiceParser do
  alias InfoCare.Api
  alias Ecto.Date
  alias InfoCare.Repo
  require Logger
  require IEx

  def all do
    case Api.get_services do
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
    |> Map.fetch!("Services")
    |> Enum.map(&parse_service/1)
  end

  defp parse_service service_data do
    rooms_data = service_data["Rooms"]

    ic_service_id = service_data["service"] |> to_string

    rooms =
      rooms_data
      |> Enum.map(&parse_room/1)

    service =
      %{
        post_code:  to_string(service_data["AddressPostCode"]),
        currency: service_data["Currency"],
        rooms: rooms,
        street: to_string(service_data["AddressStreat"]),
        suburb:  service_data["AddressSuburb"],
        ic_service_id: to_string(service_data["ServiceID"]),
        name: service_data["Name"],
        email: service_data["Email"],
        capacity: service_data["MaxChildren"],
        max_o2: service_data["MaxO2"],
        max_u2: service_data["MaxU2"],
        phone_number: service_data["PhoneNumber"]
      }
  end

  defp parse_room room_data do
    %{
      name: room_data["Name"],
    }
  end

end
