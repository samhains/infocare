defmodule InfoCare.RoomTest do
  require IEx
  use InfoCare.ModelCase

  alias InfoCare.Room
  alias InfoCare.RoomFixtures
  alias InfoCare.ServiceFixtures

  @valid_attrs %{service_id: 2, name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Room.changeset(%Room{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Room.changeset(%Room{}, @invalid_attrs)
    refute changeset.valid?
  end
end
