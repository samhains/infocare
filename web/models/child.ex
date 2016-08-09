defmodule InfoCare.Child do
  require IEx
  use InfoCare.Web, :model

  schema "children" do
    field :first_name, :string
    field :last_name, :string
    field :qk_child_id, :string
    field :dob, Timex.Ecto.Date
    field :sync_id, :string
    belongs_to :parent, InfoCare.Parent
    has_many :bookings, InfoCare.Booking
    many_to_many :services, InfoCare.Service, join_through: "child_services"
    many_to_many :rooms, InfoCare.Room, join_through: "child_rooms"

    timestamps
  end

  @required_fields ~w(qk_child_id)
  @optional_fields ~w(sync_id dob parent_id first_name last_name dob sync_id)
  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> unique_constraint(:qk_child_id)
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
