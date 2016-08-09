defmodule InfoCare.ParentParser do
  alias InfoCare.Api
  alias Ecto.Date
  alias InfoCare.Repo
  require Logger
  require IEx


  # def all do
  #   case Api.get_parents  do
  #     {:ok, response} ->
  #       parents = parse(response)
  #       {:ok, parents}
  #     {:error, error} ->
  #       Logger.error (inspect error)
  #       {:error, error}
  #   end
  # end

  def parse response_data do
    response_data
    |> Map.fetch!("value")
    |> Enum.map(&parse_parent/1)
  end


  defp parse_parent parent_data do
    IEx.pry
    children_data = parent_data["Children"]
    ic_parent_id = parent_data["ParentId"] |> to_string

    children =
      children_data
      |> Enum.map(&parse_child/1)

    %{
      ic_parent_id: ic_parent_id,
      account_relationship: parent_data["AccountRelationship"],
      phone: parent_data["MobilePhoneNumber"],
      first_name: parent_data["GivenName"] ,
      last_name: parent_data["Surname"],
      children: children
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
