defmodule InfoCare.Repo.Migrations.AddAvailabilitiesTable do
  use Ecto.Migration

  def change do
    create table(:availabilities) do
      add :over_2, :integer
      add :under_2, :integer
      add :total, :integer
      add :service_id, references(:services, on_delete: :nothing)
      add :start_time, :datetime
      add :end_time, :datetime
      timestamps
    end
  end
end
