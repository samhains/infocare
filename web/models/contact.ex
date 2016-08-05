defmodule InfoCare.Contact do
  use InfoCare.Web, :model

  schema "contacts" do
    field :first_name, :string
    field :last_name, :string
    field :qk_contact_id, :string
    field :phone, :string
    field :account_relationship, :string
    belongs_to :family, InfoCare.Family

    timestamps
  end

  @required_fields ~w(qk_contact_id)
  @optional_fields ~w(account_relationship phone first_name last_name)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> unique_constraint(:qk_contact_id)
  end
end

defimpl Collectable, for: InfoCare.Contact do
  def into(original) do
    {original, fn
      map, {:cont, {k, v}} -> %{ map | k => v}
      map, :done -> map
      _, :halt -> :ok
    end}
  end
end
