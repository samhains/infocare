defmodule InfoCare.UpdateFamiliesTest do
  use ExUnit.Case, async: false
  use InfoCare.ConnCase

  alias InfoCare.Family
  alias InfoCare.Child
  alias InfoCare.Contact
  alias InfoCare.FamilyMocks
  alias InfoCare.SharedMocks

  import Mock
  import IEx
  @get_families_url "https://www.qkenhanced.com.au/Enhanced.KindyNow/v1/odata/Families?$expand=Contacts,Children&$skip=200"


  defp mock_api_and_run_job do
    with_mock HTTPoison, [get: fn(_url, _headers) -> {:ok, FamilyMocks.valid_response } end] do
      HTTPoison.get(@get_families_url, [foo: :bar])
      services = InfoCare.UpdateFamilies.update_families 1
    end
  end

  test "saves familes, children and contacts to database given valid api response" do
    mock_api_and_run_job
    assert Repo.one(from f in Family, select: count("*")) == 3
    assert Repo.one(from c in Child, select: count("*")) == 4
    assert Repo.one(from c in Contact, select: count("*")) == 4
  end

  test "returns error for invalid api response" do
    with_mock HTTPoison, [get: fn(_url, _headers) -> {:error, SharedMocks.invalid_response } end] do
      HTTPoison.get(@get_families_url, [foo: :bar])
      services = InfoCare.UpdateFamilies.update_families 1
      {error, reason} = services
      assert error == :error
    end
  end

  test "returns ok for valid api response" do
    services = mock_api_and_run_job
    {ok, data} = services
    assert ok == :ok
  end

  test "associates family with the relevant child and contact" do
    mock_api_and_run_job

    qk_family_id = "321222"
    family = Repo.one(from f in Family, where: f.qk_family_id == ^qk_family_id, preload: [:children, :contacts])
    assert length(family.children) == 1
    assert length(family.contacts) == 2
  end

  test "updates existing services and their associations given valid inputs" do
    mock_api_and_run_job

    with_mock HTTPoison, [get: fn(_url, _headers) -> {:ok, FamilyMocks.update_response } end] do
      HTTPoison.get(@get_families_url, [foo: :bar])
      services = InfoCare.UpdateFamilies.update_families 1
      qk_family_id = "321222"
      family = Repo.one(from f in Family, where: f.qk_family_id == ^qk_family_id, preload: [:children, :contacts])
      child_1 = family.children |> List.first
      contact_1 = family.contacts |> List.first
      contact_2 = family.contacts |> List.last
      assert Map.get(child_1, :last_name) == "Hains"
      assert Map.get(contact_1, :first_name) == "Samuel"
      assert Map.get(contact_2, :phone) == "0492 287 287"
    end
  end
end
