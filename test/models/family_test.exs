defmodule InfoCare.FamilyTest do
  use InfoCare.ModelCase

  alias InfoCare.Family

  @valid_attrs %{qk_family_id: "324234"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Family.changeset(%Family{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Family.changeset(%Family{}, @invalid_attrs)
    refute changeset.valid?
  end
end
