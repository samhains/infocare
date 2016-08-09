defmodule InfoCare.UpdateServices do
  require IEx
  alias InfoCare.Service
  alias InfoCare.Room
  alias InfoCare.Repo
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
    ic_service_id = service.ic_service_id
    rooms = service.rooms

    service_changeset = Service.changeset(%Service{}, service)

    case Repo.one(from s in Service, where: s.ic_service_id == ^ic_service_id, preload: [:rooms]) do
      record when is_nil record ->
        case Repo.insert(service_changeset) do
          {:ok, service} ->
            insert_rooms service, rooms
            {:ok, service}
          {:error, service_changeset} ->
            Logger.error (inspect service_changeset.errors)
        end

      record ->
        record
        |> Service.changeset(service)
        |> Repo.update
        |> response_handler

        clear_rooms record
        insert_rooms record, rooms
    end
  end

  defp clear_rooms service do
    service_id = service.id
    Repo.delete_all(from r in Room, where: r.service_id == ^service_id)
  end

  defp insert_rooms service, rooms do
    Enum.map(rooms, fn (room) ->
      room
      |> Map.put(:service_id, service.id)
      |> insert_record(Room, %Room{})
    end)
  end

end
