defmodule InfoCare.ServiceParserTest do
  use ExUnit.Case, async: false
  use InfoCare.ConnCase

  alias InfoCare.ServiceParser
  alias InfoCare.ServiceMocks

  require IEx

  test "returns list of services from api data and service list" do
    services =
      ServiceMocks.valid_response_body
      |> Poison.decode!
      |> ServiceParser.parse

    first_service = services |> List.first
    test_service = %{building: "", email: "queanbeyan@kindypatch.com.au", licensed_capacity: "76", name: "Kindy Patch Cuddly Bear Queanbeyan", phone_number: "0262997572", post_code: "2620", qk_service_id: "317877", rooms: [%{active: true, max_age: 24, min_age: 0, name: "LITTLE BEARS- NURSERY", qk_room_id: "318858"}, %{active: true, max_age: 24, min_age: 12, name: "POOH BEARS- TINY TOTS", qk_room_id: "319132"}, %{active: true, max_age: 36, min_age: 24, name: "HUMPHREY BEARS- TODDLERS", qk_room_id: "319151"}, %{active: true, max_age: 60, min_age: 48, name: "BIG BEARS - PRESCHOOL", qk_room_id: "319166"}, %{active: true, max_age: 60, min_age: 36, name: "PANDA BEARS- JUNIOR PRESCHOOL", qk_room_id: "319167"}], state: "NSW", street: "275 Crawford St", suburb: "Queanbeyan", time_zone: "Australia/Sydney"}

    assert length(services) == 2
    assert Map.equal?(test_service, first_service)
  end
end
