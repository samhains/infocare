defmodule InfoCare.Repo.Migrations.AddAvailabilitiesTable do
  use Ecto.Migration

  def change do
    create table(:availabilities) do
      add :date, :datetime
      add :open, :boolean
      add :used, :integer
      add :capacity, :integer
      add :service_id, references(:services, on_delete: :nothing)
      add :room_id, references(:rooms, on_delete: :nothing)

      timestamps
    end

    create index(:availabilities, [:service_id, :room_id])
  end
end
