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
    test_service = %{currency: "NZD", email: "russell@info-care.biz", ic_service_id: "671", capacity: "35", max_o2: "35", max_u2: "10", name: "Infocare Test", phone_number: "09 4799553", post_code: "1311", rooms: [%{name: "Holiday"}, %{name: "Tui Room"}], street: "3-92 Churchill Road", suburb: "Rothesay Bay"}

    assert length(services) == 8
    assert Map.equal?(test_service, first_service)
  end
end
