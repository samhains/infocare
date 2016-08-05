defmodule InfoCare.Repo.Migrations.CreateChildService do
  use Ecto.Migration

  def change do
    create table(:child_services) do
      add :service_id, references(:services, on_delete: :nothing)
      timestamps
    end

    create index(:child_services, [:service_id])
  end
end
