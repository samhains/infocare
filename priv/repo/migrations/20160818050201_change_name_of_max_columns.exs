defmodule InfoCare.Repo.Migrations.ChangeNameOfMaxColumns do
  use Ecto.Migration

  def change do
    alter table(:services) do
      remove :max_O2
      remove :max_U2
      add :max_O2, :integer
      add :max_U2, :integer
    end

  end
end
