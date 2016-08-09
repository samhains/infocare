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
    assert Repo.one(from s in Service, select: count("*")) == 2
    assert Repo.one(from r in Room, select: count("*")) == 12
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

  # test "associates rooms with the relevant service" do
  #   mock_api_and_run_job

  #   ic_service_id = "671"
  #   service = Repo.one(from s in Service, where: s.qk_service_id == ^qk_service_id, preload: [:rooms])

  #   assert length(service.rooms) == 5
  # end

  # test "updates existing services and their associations given valid inputs" do
  #   mock_api_and_run_job

  #   with_mock HTTPoison, [get: fn(_url, _headers) -> {:ok, ServiceMocks.update_response} end] do
  #     HTTPoison.get(@get_services_url, [foo: :bar])
  #     qk_service_id = "317877"
  #     qk_room_id = "318858"
  #     services = InfoCare.UpdateServices.run
  #     service = Repo.one(from s in Service, where: s.qk_service_id == ^qk_service_id)
  #     room = Repo.one(from r in Room, where: r.qk_room_id == ^qk_room_id)

  #     assert service.licensed_capacity == "100"
  #     assert service.state == "VIC"
  #     assert room.qk_room_id == "318858"
  #     assert room.name == "LITTLE PONY- NURSERY"
  #   end

  # end


  # test "marks rooms that are no longer present in api response as inactive" do
  #   mock_api_and_run_job
  #   with_mock HTTPoison, [get: fn(_url, _headers) -> {:ok, ServiceMocks.less_rooms_response} end] do
  #     HTTPoison.get(@get_services_url, [foo: :bar])
  #     qk_room_id = "318858"
  #     qk_room_id_2 = "319166"
  #     services = InfoCare.UpdateServices.run
  #     room = Repo.one(from r in Room, where: r.qk_room_id == ^qk_room_id)
  #     room_2 = Repo.one(from r in Room, where: r.qk_room_id == ^qk_room_id_2)
  #     assert room.active == false
  #     assert room_2.active == true
  #   end
  # end
end
