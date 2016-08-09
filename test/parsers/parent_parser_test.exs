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
    test_parent = %{}

    assert length(parents) == 3
    assert Map.equal?(test_parent, first_parent)
  end
end
