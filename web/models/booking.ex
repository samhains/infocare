defmodule InfoCare.Booking do
  require IEx
  use InfoCare.Web, :model

  schema "bookings" do
    field :date, Timex.Ecto.DateTime
    field :fee, :integer
    field :start_time, Timex.Ecto.DateTime
    field :end_time, Timex.Ecto.DateTime
    field :reminder_time, Timex.Ecto.DateTime
    field :expiry_time, Timex.Ecto.DateTime
    field :reminder_send, :boolean
    field :absent, :boolean
    field :rebooked, :boolean
    field :utilisation, :string
    field :qk_booking_id, :string
    field :day_status, :string
    field :permanent_booking, :string
    belongs_to :service, InfoCare.Service
    belongs_to :contact, InfoCare.Contact
    belongs_to :child, InfoCare.Child
    belongs_to :room, InfoCare.Room
    belongs_to :booking_type, InfoCare.BookingType

    timestamps
  end

  @required_fields ~w(qk_booking_id)
  @optional_fields ~w(day_status date start_time end_time reminder_time expiry_time reminder_time absent rebooked utilisation day_status permanent_booking service_id contact_id child_id room_id booking_type_id)

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
