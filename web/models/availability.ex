defmodule InfoCare.Availability do
  use InfoCare.Web, :model

  schema "availabilities" do
    field :date, Timex.Ecto.DateTime
    field :over_2, :integer
    field :under_2, :integer
    field :total, :integer
    belongs_to :service, InfoCare.Service
    belongs_to :session, InfoCare.Session

    timestamps
  end

  @required_fields ~w(over_2 under_2 total service_id date)
  @optional_fields ~w(session_id)

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
