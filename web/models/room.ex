defmodule InfoCare.Room do
  require IEx

  use InfoCare.Web, :model
  use Timex.Ecto.Timestamps

  schema "rooms" do
    field :name, :string
    belongs_to :service, InfoCare.Service
    many_to_many :children, InfoCare.Child, join_through: :child_rooms
    timestamps
  end

  @required_fields ~w(name service_id)
  @optional_fields ~w()

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

defimpl Collectable, for: InfoCare.Room do
  def into(original) do
    {original, fn
      map, {:cont, {k, v}} -> %{ map | k => v}
      map, :done -> map
      _, :halt -> :ok
    end}
  end
end
