defmodule InfoCare.Booking do
  require IEx
  use InfoCare.Web, :model

  schema "bookings" do
    field :ic_booking_id, :string
    field :start_time, Timex.Ecto.DateTime
    field :end_time, Timex.Ecto.DateTime
    field :date, Timex.Ecto.DateTime
    belongs_to :service, InfoCare.Service
    belongs_to :parent, InfoCare.Parent
    belongs_to :child, InfoCare.Child

    timestamps
  end

  @required_fields ~w(ic_booking_id)
  @optional_fields ~w(start_time end_time date service parent child)

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

defimpl Collectable, for: InfoCare.Booking do
  def into(original) do
    {original, fn
      map, {:cont, {k, v}} -> %{ map | k => v}
      map, :done -> map
      _, :halt -> :ok
    end}
  end
end
