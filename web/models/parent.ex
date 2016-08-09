defmodule InfoCare.Parent do
  use InfoCare.Web, :model

  schema "families" do
    has_many :children, InfoCare.Child
    has_many :contacts, InfoCare.Contact
    field :ic_parent_id, :string

    timestamps
  end

  @required_fields ~w(ic_parent_id)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> unique_constraint(:ic_parent_id)
  end
end
