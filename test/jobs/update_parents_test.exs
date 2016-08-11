defmodule InfoCare.UpdateParentsTest do
  use ExUnit.Case, async: false
  use InfoCare.ConnCase

  alias InfoCare.Parent
  alias InfoCare.Child
  alias InfoCare.Contact
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
    assert Repo.one(from f in Parent, select: count("*")) == 3
    assert Repo.one(from c in Child, select: count("*")) == 4
    assert Repo.one(from c in Contact, select: count("*")) == 4
  end

  # test "returns error for invalid api response" do
  #   with_mock HTTPoison, [post: fn(_url, _headers) -> {:error, SharedMocks.invalid_response } end] do
  #     HTTPoison.post(@post_parents_url, [foo: :bar])
  #     services = InfoCare.UpdateParents.update_parents 1
  #     {error, reason} = services
  #     assert error == :error
  #   end
  # end

  # test "returns ok for valid api response" do
  #   services = mock_api_and_run_job
  #   {ok, data} = services
  #   assert ok == :ok
  # end

  # test "associates parent with the relevant child and contact" do
  #   mock_api_and_run_job

  #   ic_parent_id = "321222"
  #   parent = Repo.one(from f in Parent, where: f.ic_parent_id == ^ic_parent_id, preload: [:children, :contacts])
  #   assert length(parent.children) == 1
  #   assert length(parent.contacts) == 2
  # end

  # test "updates existing services and their associations given valid inputs" do
  #   mock_api_and_run_job

  #   with_mock HTTPoison, [post: fn(_url, _headers) -> {:ok, ParentMocks.update_response } end] do
  #     HTTPoison.post(@post_parents_url, [foo: :bar])
  #     services = InfoCare.UpdateParents.update_parents 1
  #     ic_parent_id = "321222"
  #     parent = Repo.one(from f in Parent, where: f.ic_parent_id == ^ic_parent_id, preload: [:children, :contacts])
  #     child_1 = parent.children |> List.first
  #     contact_1 = parent.contacts |> List.first
  #     contact_2 = parent.contacts |> List.last
  #     assert Map.post(child_1, :last_name) == "Hains"
  #     assert Map.post(contact_1, :first_name) == "Samuel"
  #     assert Map.post(contact_2, :phone) == "0492 287 287"
  #   end
  # end
end
