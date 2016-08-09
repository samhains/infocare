defmodule InfoCare.ParentTest do
  use InfoCare.ModelCase

  alias InfoCare.Parent

  @valid_attrs %{ic_parent_id: "324234"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Parent.changeset(%Parent{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Parent.changeset(%Parent{}, @invalid_attrs)
    refute changeset.valid?
  end
end
