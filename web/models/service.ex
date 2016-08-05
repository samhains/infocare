defmodule InfoCare.Service do
  use InfoCare.Web, :model
  @derive {Poison.Encoder, only: [:id, :name, :qk_service_id, :email, :phone_number, :time_zone, :licensed_capacity, :street, :suburb, :state, :post_code, :rooms, :children]}

  schema "services" do
    field :name, :string
    field :qk_service_id, :string
    field :email, :string
    field :phone_number, :string
    field :time_zone, :string
    field :licensed_capacity, :string
    field :street, :string
    field :suburb, :string
    field :state, :string
    field :post_code, :string

    # many_to_many :children, InfoCare.Child, join_through: :child_services
    has_many :rooms, InfoCare.Room

    timestamps
  end

  @required_fields ~w(qk_service_id name)
  @optional_fields ~w(email phone_number licensed_capacity time_zone suburb street suburb state post_code state post_code)

  @doc """
  Creates a changeset based on the `model` and `params`.
  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
