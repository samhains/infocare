defmodule InfoCare.Repo.Migrations.AddChildIdToJoinTable do
  use Ecto.Migration

  def change do
    alter table(:child_services) do
      add :child_id, references(:children, on_delete: :nothing)
    end
  end
end
