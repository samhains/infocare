defmodule InfoCare.UpdateParents do
  require IEx
  require Logger
  alias InfoCare.Parent
  alias InfoCare.Child
  alias InfoCare.Service
  alias InfoCare.Contact
  alias InfoCare.Repo
  alias InfoCare.ParentParser

  import InfoCare.JobsHelper
  import Ecto.Query


  def run do
    Repo.all(Service)
    |> Stream.map(&update_parents_for_service/1)
    |> Stream.run
  end

  def update_parents_for_service service do

    maybe_parents_data = ParentParser.by_service service

    case maybe_parents_data do
      {:ok, parents_data} ->
        parents =
          parents_data
            |> Enum.map(&insert_or_update_parent/1)
        {:ok, parents}
      {:error, error} ->
        Logger.error (inspect error)
        {:error, error}
    end

  end

  defp insert_or_update_parent parent do
    ic_parent_id = parent.ic_parent_id
    parent_changeset = Parent.changeset(%Parent{}, %{:ic_parent_id => ic_parent_id})
    children = parent.children

    case Repo.one(from f in Parent, where: f.ic_parent_id == ^ic_parent_id) do
      record when is_nil record ->
        case Repo.insert(parent_changeset) do
          {:ok, parent} ->
            update_associations parent, children
            {:ok, parent}
          {:error, parent_changeset} ->
            Logger.error (inspect parent_changeset.errors)
        end
     record ->
        update_associations record, children
    end
  end

  defp update_associations parent, children do
    children
    |> Enum.map(fn(child)->
      ic_service_id = child.ic_service_id
      service = Repo.one(from s in Service, where: s.ic_service_id == ^ic_service_id)

      child
      |> Map.put(:parent_id, parent.id)
      |> Map.put(:service_id, service.id)
      |> Map.delete(:ic_service_id)
    end)
    |> Enum.map(&save_child/1)
  end

  defp save_child child do
    child_id = child.ic_child_id
    query = from c in Child, where: c.ic_child_id == ^child_id

    insert_or_update_record_and_print_errors(child, Child, %Child{}, query)
  end
end
