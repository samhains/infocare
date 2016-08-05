defmodule InfoCare.Room do
  require IEx

  use InfoCare.Web, :model
  use Timex.Ecto.Timestamps

  alias InfoCare.Mapper

  schema "rooms" do
    field :name, :string
    field :min_age, :integer
    field :max_age, :integer
    field :capacity, :integer
    field :active, :boolean
    field :qk_room_id, :string
    field :sync_id, :string
    field :casual_booking_type, :string
    belongs_to :service, InfoCare.Service

    many_to_many :children, InfoCare.Child, join_through: :child_rooms
    timestamps
  end

  @required_fields ~w(qk_room_id service_id active name sync_id)
  @optional_fields ~w(capacity casual_booking_type min_age max_age)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    qk_room_id =
      if Map.has_key?(params, :qk_room_id) do
        Map.get(params, :qk_room_id)
      else
        Map.get(model, :qk_room_id)
      end

    params = Map.put(params, :sync_id, Mapper.roll_id_to_roll_sync_id[qk_room_id])

    model
    |> cast(params, @required_fields, @optional_fields)
  end
end

defimpl Collectable, for: InfoCare.Room do
  def into(original) do
    {original, fn
      map, {:cont, {k, v}} -> %{ map | k => v}
      map, :done -> map
      _, :halt -> :ok
    end}
  end
end
