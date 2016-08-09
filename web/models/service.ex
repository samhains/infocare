defmodule InfoCare.Service do
  require IEx
  use InfoCare.Web, :model
  @derive {Poison.Encoder, only: [:ic_service_id, :name, :email, :currency, :licensed_capacity, :phone_number, :time_zone, :street, :suburb, :state, :country, :post_code]}

  schema "services" do
    field :ic_service_id, :string
    field :name, :string
    field :email, :string
    field :currency, :string
    field :licensed_capacity, :string
    field :phone_number, :string
    field :time_zone, :string
    field :street, :string
    field :suburb, :string
    field :state, :string
    field :country, :string
    field :post_code, :string
    has_many :rooms, InfoCare.Room

    timestamps
  end

  @required_fields ~w(ic_service_id)
  @optional_fields ~w(name email currency licensed_capacity phone_number time_zone street suburb state country post_code)

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
