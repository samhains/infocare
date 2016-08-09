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
    test_parent = %{children: [%{dob: ~N[2009-08-21 00:00:00], first_name: "Jane", ic_child_id: "e26821a7-887a-4272-b2b6-fbea566fb803", ic_service_id: "0322c866-862f-4cdf-a4aa-8113161825ce", last_name: "Doe"}, %{dob: ~N[2009-08-21 00:00:00], first_name: "Jim", ic_child_id: "e26821a7-887a-4272-b2b6-fbea566fb805", ic_service_id: "0322c866-862f-4cdf-a4aa-811316182lcf", last_name: "Doe"}], first_name: "John", ic_parent_id: "2a8a0c03-8a75-464a-8ed1-aefd87284e7c", last_name: "Doe"}

    assert length(parents) == 2
    assert Map.equal?(test_parent, first_parent)
  end
end
