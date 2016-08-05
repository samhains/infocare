defmodule InfoCare.Repo.Migrations.AddSyncIdToRoomsModel do
  use Ecto.Migration

  def change do
    alter table(:rooms) do
      add :sync_id, :string
    end
  end
end
