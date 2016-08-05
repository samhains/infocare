defmodule InfoCare.BookingTypeTest do
  use InfoCare.ModelCase

  alias InfoCare.BookingType

  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = BookingType.changeset(%BookingType{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = BookingType.changeset(%BookingType{}, @invalid_attrs)
    refute changeset.valid?
  end
end
