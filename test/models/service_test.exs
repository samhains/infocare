defmodule InfoCare.ServiceTest do
  use InfoCare.ModelCase

  alias InfoCare.Service

  @valid_attrs %{ic_service_id: "2342342"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Service.changeset(%Service{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Service.changeset(%Service{}, @invalid_attrs)
    refute changeset.valid?
  end
end
