defmodule InfoCare.UpdateFamilies do
  require IEx
  require Logger
  alias InfoCare.Family
  alias InfoCare.Child
  alias InfoCare.Contact
  alias InfoCare.Repo
  alias InfoCare.FamilyParser

  import InfoCare.JobsHelper
  import Ecto.Query

  def run do
    parallel_update_families 1
 end

  def parallel_update_families batch do
    page_min = (20 * batch) - 19
    page_max = 20 * batch
    data =
      page_min..page_max
      |> ParallelStream.map(&update_families/1)
      |> Enum.into([])
    case Enum.find data, fn(x) -> x==-1 end do
        nil ->
          parallel_update_families(batch+1)
        _ ->
          Logger.info "Finished Updating Families"
    end
  end

  def update_families page do

    maybe_families_data = page |> FamilyParser.by_page

    case maybe_families_data do
      {:ok, families_data} ->
        next_url = families_data.next_url

        families = families_data.families

        families
          |> Enum.map(&insert_or_update_family/1)

        case next_url do
          next_url when is_nil next_url ->
            -1
          next_url ->
            skip =
              next_url
              |> String.split("=")
            |> List.last
            |> String.to_integer
            skip/100
        end
        {:ok, families}
      {:error, error} ->
        Logger.error (inspect error)
        {:error, error}
    end

  end

  defp insert_or_update_family family do
    qk_family_id = family.qk_family_id
    family_changeset = Family.changeset(%Family{}, %{:qk_family_id => qk_family_id})
    children = family.children
    contacts = family.contacts

    case Repo.one(from f in Family, where: f.qk_family_id == ^qk_family_id) do
      record when is_nil record ->
        case Repo.insert(family_changeset) do
          {:ok, family} ->
            update_associations family, contacts, children
            {:ok, family}
          {:error, family_changeset} ->
            Logger.error (inspect family_changeset.errors)
        end
     record ->
        update_associations record, contacts, children
    end
  end

  defp update_associations family, contacts, children do
    children
    |> Enum.map(fn(child)->
      Map.put(child, :family_id, family.id)
    end)
    |> Enum.map(&save_child/1)

    contacts
    |> Enum.map(fn(contact)->
      Map.put(contact, :family_id, family.id)
    end)
    |> Enum.map(&save_contact/1)
  end

  defp save_contact contact do
    contact_id = contact.qk_contact_id
    query = from c in Contact, where: c.qk_contact_id == ^contact_id
    insert_record_and_print_errors(contact, Contact, %Contact{}, query)
  end

  defp save_child child do
    child_id = child.qk_child_id
    query = from c in Child, where: c.qk_child_id == ^child_id

    insert_record_and_print_errors(child, Child, %Child{}, query)
  end
end
