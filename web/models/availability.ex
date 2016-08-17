defmodule InfoCare.Availability do
  use InfoCare.Web, :model

  schema "availabilities" do
    field :start_time, Timex.Ecto.DateTime
    field :end_time, Timex.Ecto.DateTime
    field :over_2, :integer
    field :under_2, :integer
    field :total, :integer
    belongs_to :service, InfoCare.Service

    timestamps
  end

  @required_fields ~w(start_time end_time over_2 under_2 total service_id)
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

defimpl Collectable, for: InfoCare.Availability do
  def into(original) do
    {original, fn
      map, {:cont, {k, v}} -> %{ map | k => v}
      map, :done -> map
      _, :halt -> :ok
    end}
  end
end
