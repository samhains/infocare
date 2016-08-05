defmodule InfoCare.ChildTest do
  use InfoCare.ModelCase

  alias InfoCare.Child

  @valid_attrs %{qk_child_id: "2342", dob: Timex.now, first_name: "some content", last_name: "some content", sync_id: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Child.changeset(%Child{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Child.changeset(%Child{}, @invalid_attrs)
    refute changeset.valid?
  end
end
