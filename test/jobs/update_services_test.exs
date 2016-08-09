defmodule InfoCare.UpdateServicesTest do
  use ExUnit.Case, async: false
  use InfoCare.ConnCase

  alias InfoCare.Service
  alias InfoCare.Room
  alias InfoCare.Repo
  alias InfoCare.ServiceMocks
  alias InfoCare.SharedMocks

  import Mock
  import Ecto.Query
  import IEx

  @get_services_url "mockurl.com"

  defp mock_api_and_run_job do
    with_mock HTTPoison, [post: fn(_url, _headers) -> {:ok, ServiceMocks.valid_response} end] do
      HTTPoison.post(@get_services_url, [foo: :bar])
      services = InfoCare.UpdateServices.run
    end
  end


  test "saves services and rooms to database given valid api response" do
    services = mock_api_and_run_job
    assert Repo.one(from s in Service, select: count("*")) == 8
    assert Repo.one(from r in Room, select: count("*")) == 4
  end

  test "returns error for invalid api response" do
    with_mock HTTPoison, [post: fn(_url, _headers) -> {:error, SharedMocks.invalid_response} end] do
      HTTPoison.post(@get_services_url, [foo: :bar])

      services = InfoCare.UpdateServices.run
      {error, reason} = services
      assert error == :error
    end
  end

  test "returns ok for valid api response" do
    services = mock_api_and_run_job
    {ok, data} = services
    assert ok == :ok
  end

  test "associates rooms with the relevant service" do
    mock_api_and_run_job

    ic_service_id = "671"
    service = Repo.one(from s in Service, where: s.ic_service_id == ^ic_service_id, preload: [:rooms])

    assert length(service.rooms) == 2
  end

  test "updates existing services and their associations given valid inputs" do
    mock_api_and_run_job

    with_mock HTTPoison, [post: fn(_url, _headers) -> {:ok, ServiceMocks.update_response} end] do
      HTTPoison.post(@get_services_url, [foo: :bar])
      ic_service_id = "671"
      services = InfoCare.UpdateServices.run
      service = Repo.one(from s in Service, where: s.ic_service_id == ^ic_service_id, preload: [:rooms])
      rooms = service.rooms
      room = rooms |> List.first

      assert service.phone_number == "09 5799553"
      assert service.name == "Infocare Test 2"
      assert length(rooms) == 2
      assert room.name == "Vacation"
    end

  end
end
