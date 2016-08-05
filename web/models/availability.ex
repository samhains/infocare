defmodule InfoCare.Availability do
  use InfoCare.Web, :model

  schema "availabilities" do
    field :date, Timex.Ecto.DateTime
    field :open, :boolean
    field :used, :integer
    field :capacity, :integer
    belongs_to :room, InfoCare.Room
    belongs_to :service, InfoCare.Service

    timestamps
  end

  @required_fields ~w(date open used capacity room_id)
  @optional_fields ~w(service_id)

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

defimpl Collectable, for: InfoCare.Availability do
  def into(original) do
    {original, fn
      map, {:cont, {k, v}} -> %{ map | k => v}
      map, :done -> map
      _, :halt -> :ok
    end}
  end
end
