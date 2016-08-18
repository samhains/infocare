defmodule InfoCare.Session do
  use InfoCare.Web, :model

  schema "sessions" do
    field :start_time, Timex.Ecto.DateTime
    field :end_time, Timex.Ecto.DateTime
    field :all_day, :boolean
    belongs_to :service, InfoCare.Service

    timestamps
  end

  @required_fields ~w(service_id start_time end_time all_day)
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
