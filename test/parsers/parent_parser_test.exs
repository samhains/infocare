defmodule InfoCare.ParentParserTest do
  use ExUnit.Case, async: false
  use InfoCare.ConnCase

  alias InfoCare.ParentParser
  alias InfoCare.ParentMocks

  require IEx

  test "returns list of parents from api data and service list" do
    parents =
      ParentMocks.valid_response_body
      |> Poison.decode!
      |> ParentParser.parse

    first_parent = parents |> List.first
    test_parent =
      %{
        children: [%{dob: ~N[2012-01-10 00:00:00], first_name: "Barry", ic_child_id: "712", ic_service_id: "671", last_name: "White"}, %{dob: ~N[2012-01-10 00:00:00], first_name: "Barry", ic_child_id: "739", ic_service_id: "679", last_name: "White"}],
        first_name: "Phil",
        ic_parent_id: "5303",
        last_name: "Snowdon"
      }


    assert length(parents) == 2
    assert Map.equal?(test_parent, first_parent)
  end
end
