defmodule InfoCare.Repo.Migrations.ChangeChildDobToEctoTime do
  use Ecto.Migration

  def change do
    alter table(:children) do
      remove :dob
      add :dob, :datetime
    end
  end
end
