defmodule InfoCare.FamilyParser do
  alias InfoCare.QkApi
  alias Ecto.Date
  alias InfoCare.Repo
  require Logger
  require IEx


  def by_service service do
    case QkApi.get_families_by_service(service)  do
      {:ok, response} ->
        families = parse(response)
        {:ok, families}
      {:error, error} ->
        Logger.error (inspect error)
        {:error, error}
    end
  end

  def parse response_data do
    response_data
    |> Map.fetch!("value")
    |> Enum.map(&parse_family/1)
  end


  defp parse_family family_data do
    contacts_data = family_data["Contacts"]
    children_data = family_data["Children"]
    qk_family_id = family_data["FamilyId"] |> to_string

    contacts =
      contacts_data
      |> Enum.map(&parse_contact/1)
    children =
      children_data
      |> Enum.map(&parse_child/1)

    %{
      qk_family_id: qk_family_id,
      contacts: contacts,
      children: children
     }
  end

  defp parse_contact contact_data do
    %{
      qk_contact_id: to_string(contact_data["ContactId"]),
      account_relationship: contact_data["AccountRelationship"],
      phone: contact_data["MobilePhoneNumber"],
      first_name: contact_data["GivenName"] ,
      last_name: contact_data["Surname"]
    }
  end

  defp parse_child child_data do
    dob = child_data["DateOfBirth"]
    date = if dob, do: Timex.parse!(dob,"%FT%TZ", :strftime)

    %{
      qk_child_id: to_string(child_data["ChildId"]),
      dob: date,
      sync_id: child_data["SyncId"],
      first_name: child_data["GivenName"],
      last_name: child_data["Surname"]
    }
  end

end
