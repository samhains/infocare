defmodule InfoCare.Child do
  require IEx
  use InfoCare.Web, :model

  schema "children" do
    field :first_name, :string
    field :last_name, :string
    field :ic_child_id, :string
    field :dob, Timex.Ecto.DateTime
    belongs_to :parent, InfoCare.Parent
    belongs_to :service, InfoCare.Service
    # has_many :bookings, InfoCare.Booking
    # many_to_many :rooms, InfoCare.Room, join_through: "child_rooms"

    timestamps
  end

  @required_fields ~w(ic_child_id parent_id)
  @optional_fields ~w(dob first_name service_id last_name)
  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> unique_constraint(:ic_child_id)
  end
end

defimpl Collectable, for: InfoCare.Child do
  def into(original) do
    {original, fn
      map, {:cont, {k, v}} -> %{ map | k => v}
      map, :done -> map
      _, :halt -> :ok
    end}
  end
end
