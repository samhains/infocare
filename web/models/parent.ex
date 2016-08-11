defmodule InfoCare.Parent do
  use InfoCare.Web, :model

  schema "parents" do
    field :ic_parent_id, :string
    field :first_name, :string
    field :last_name, :string
    has_many :children, InfoCare.Child

    timestamps
  end

  @required_fields ~w(ic_parent_id)
  @optional_fields ~w(first_name last_name)

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

defimpl Collectable, for: InfoCare.Parent do
  def into(original) do
    {original, fn
      map, {:cont, {k, v}} -> %{ map | k => v}
      map, :done -> map
      _, :halt -> :ok
    end}
  end
end
