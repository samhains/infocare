defmodule InfoCare.Repo.Migrations.AddAgeMaxToServices do
  use Ecto.Migration

  def change do
    alter table(:services) do
      add :max_O2, :integer
      add :max_U2, :integer
      remove :licensed_capacity
      add :capacity, :integer
    end
  end
end
