defmodule InfoCare.ParentParser do
  alias InfoCare.Api
  alias Ecto.Date
  alias InfoCare.Repo
  require Logger
  require IEx


  def by_service service do
    case Api.get_parents_by_service service  do
      {:ok, response} ->
        parents = parse(response)
        {:ok, parents}
      {:error, error} ->
        Logger.error (inspect error)
        {:error, error}
    end
  end

  def parse response_data do
    response_data
    |> Map.fetch!("Parents")
    |> Enum.map(&parse_parent/1)
  end


  defp parse_parent parent_data do
    children_data = parent_data["Children"]
    ic_parent_id = parent_data["ParentID"] |> to_string

    children =
      children_data
      |> Enum.map(&parse_child/1)

    %{
      ic_parent_id: ic_parent_id,
      first_name: parent_data["FirstName"] ,
      last_name: parent_data["LastName"],
      children: children
     }
  end

  defp parse_child child_data do
    dob = child_data["DOB"]
    date = if dob, do: Timex.parse!(dob,"%F", :strftime)

    %{
      ic_child_id: to_string(child_data["ChildID"]),
      dob: date,
      first_name: child_data["FirstName"],
      last_name: child_data["LastName"],
      ic_service_id: child_data["ServiceID"]
    }
  end

end
