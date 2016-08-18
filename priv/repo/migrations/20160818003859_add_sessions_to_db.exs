defmodule InfoCare.Repo.Migrations.AddSessionsToDb do
  use Ecto.Migration

  def change do
    create table(:sessions) do
      add :start_time, :datetime
      add :end_time, :datetime
      add :all_day, :boolean
      add :service_id, references(:services, on_delete: :nothing)
    end

    alter table(:availabilities) do
      add :session_id, references(:sessions, on_delete: :nothing)
      add :date, :datetime
      remove :start_time
      remove :end_time
    end
  end
end
