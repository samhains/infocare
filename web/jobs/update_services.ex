defmodule InfoCare.UpdateServices do
  require IEx
  alias InfoCare.Service
  alias InfoCare.Room
  alias InfoCare.Repo
  alias InfoCare.QkApi
  alias InfoCare.ServiceParser

  import InfoCare.JobsHelper
  import Ecto.Query
  import Logger

  def run do

    maybe_services = ServiceParser.all

    case maybe_services do
      {:ok, services} ->
        services
            |> Stream.map(&insert_or_update_service/1)
            |> Stream.run
        {:ok, services}
      {:error, error} ->
        Logger.error (inspect error)
        {:error, error}
    end
  end

  defp insert_or_update_service service do
    qk_service_id = service.qk_service_id
    rooms = service.rooms

    service_changeset = Service.changeset(%Service{}, service)

    case Repo.one(from s in Service, where: s.qk_service_id == ^qk_service_id, preload: [:rooms]) do
      record when is_nil record ->
        case Repo.insert(service_changeset) do
          {:ok, service} ->
            insert_or_update_rooms service, rooms
            {:ok, service}
          {:error, service_changeset} ->
            Logger.error (inspect service_changeset.errors)
        end

      record ->
        make_missing_rooms_inactive record, rooms

        record
        |> Service.changeset(service)
        |> Repo.update
        |> response_handler

        insert_or_update_rooms record, rooms
    end
  end

  defp make_missing_rooms_inactive service, api_rooms do
    api_room_ids =
      api_rooms
      |> Enum.map(fn (room) -> room.qk_room_id end)

    existing_room_ids =
      service.rooms
      |> Enum.map(fn (room) -> room.qk_room_id end)

    removed_rooms =
      existing_room_ids
      |> Enum.reject(fn(id) -> Enum.member?(api_room_ids, id) end)

    from(r in Room, where: r.qk_room_id in ^removed_rooms)
    |> Repo.update_all(set: [active: false])
  end

  defp insert_or_update_rooms service, rooms do
    Enum.map(rooms, fn (room) ->
      room_id = room.qk_room_id
      query = from r in Room, where: r.qk_room_id == ^room_id
      room
      |> Map.put(:service_id, service.id)
      |> insert_record_and_print_errors Room, %Room{}, query
    end)
  end

end
