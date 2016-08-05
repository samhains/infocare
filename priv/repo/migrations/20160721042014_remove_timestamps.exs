defmodule InfoCare.Repo.Migrations.RemoveTimestamps do
  use Ecto.Migration

  def change do
    alter table(:child_services) do
      remove :inserted_at
      remove :updated_at
    end

    alter table(:child_rooms) do
      remove :inserted_at
      remove :updated_at
    end

  end
end
