defmodule InfoCare.Repo.Migrations.CreateChildRoom do
  use Ecto.Migration

  def change do
    create table(:child_rooms) do
      add :room_id, references(:rooms, on_delete: :nothing)
      add :child_id, references(:children, on_delete: :nothing)

      timestamps
    end
    create index(:child_rooms, [:room_id])
    create index(:child_rooms, [:child_id])

  end
end
