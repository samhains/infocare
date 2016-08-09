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
    test_service = %{}

    assert length(services) == 2
    assert Map.equal?(test_service, first_service)
  end
end
