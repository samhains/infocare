defmodule InfoCare.ServiceTest do
  use InfoCare.ModelCase

  alias InfoCare.Service

  @valid_attrs %{qk_service_id: "2342342", address_post_code: "some content", address_state: "some content", address_street: "some content", address_suburb: "some content", email: "some content", licensed_capacity: "some content", name: "some content", phone_number: "some content", time_zone: "some content"}
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
