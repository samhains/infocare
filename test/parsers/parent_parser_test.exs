defmodule InfoCare.ParentParserTest do
  use ExUnit.Case, async: false
  use InfoCare.ConnCase

  alias InfoCare.ParentParser
  alias InfoCare.ParentMocks

  require IEx


  test "returns list of families from api data and service list" do

    families =
      ParentMocks.valid_response_body
      |> Poison.decode!
      |> ParentParser.parse

    first_parent = families |> List.first
    test_parent =
      %{children: [%{dob: ~N[2007-02-24 00:00:00], first_name: "NICHOLAS",
                    last_name: "Hains", qk_child_id: "393540",
                    sync_id: "09e2afcf-1471-e211-a3ad-5ef3fc0d484b"}],
        contacts: [%{account_relationship: nil, first_name: "Jeffrey Paul",
                    last_name: "Hains", phone: "0492 287 287", qk_contact_id: "680892"},
                  %{account_relationship: "PrimaryContact", first_name: "Samuel",
                    last_name: "JOMA", phone: "0433 060642", qk_contact_id: "688748"}],
        ic_parent_id: "321222"}

    assert length(families) == 3
    assert Map.equal?(test_parent, first_parent)
  end
end
