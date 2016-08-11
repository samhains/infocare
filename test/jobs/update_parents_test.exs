defmodule InfoCare.UpdateParentsTest do
  use ExUnit.Case, async: false
  use InfoCare.ConnCase

  alias InfoCare.Parent
  alias InfoCare.Child
  alias InfoCare.ParentMocks
  alias InfoCare.SharedMocks
  alias InfoCare.ServiceFixtures

  import Mock
  import IEx
  @post_parents_url "mock.url"

  defp prepare_db do
    service = ServiceFixtures.service_1 |> Repo.insert!
    service = ServiceFixtures.service_2 |> Repo.insert!
  end

  defp mock_api_and_run_job do
    prepare_db
    with_mock HTTPoison, [post: fn(_url,_body, _headers) -> {:ok, ParentMocks.valid_response } end] do
      HTTPoison.post(@post_parents_url, %{}, [foo: :bar])
      services = InfoCare.UpdateParents.run
    end
  end

  test "saves familes, children and contacts to database given valid api response" do
    mock_api_and_run_job
    assert Repo.one(from f in Parent, select: count("*")) == 2
    assert Repo.one(from c in Child, select: count("*")) == 4
  end
  
  test "associates parent with the relevant child" do
    mock_api_and_run_job

    ic_parent_id = "5303"
    parent = Repo.one(from f in Parent, where: f.ic_parent_id == ^ic_parent_id, preload: [:children])
    assert length(parent.children) == 2
    assert parent.first_name == "Phil"
  end

  test "associates child with the relevant service" do
    mock_api_and_run_job

    ic_child_id = "712"
    child = Repo.one(from c in Child, where: c.ic_child_id == ^ic_child_id, preload: [:service])
    service = child.service
    assert service.ic_service_id == "671"
  end

test "updates existing services and their associations given valid inputs" do
    mock_api_and_run_job

    with_mock HTTPoison, [post: fn(_url, _body, _headers) -> {:ok, ParentMocks.update_response } end] do
      HTTPoison.post(@post_parents_url, %{}, [foo: :bar])
      services = InfoCare.UpdateParents.run
      ic_parent_id = "5303"
      parent = Repo.one(from f in Parent, where: f.ic_parent_id == ^ic_parent_id, preload: [:children])
      child_1 = parent.children |> List.last
      assert Map.get(parent, :first_name) == "Bill"
      assert Map.get(child_1, :last_name) == "Susan"
    end
  end
end
