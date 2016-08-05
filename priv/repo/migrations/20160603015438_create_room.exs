defmodule InfoCare.Repo.Migrations.CreateRoom do
  use Ecto.Migration

  def change do
    create table(:rooms) do
      add :name, :string
      add :active, :boolean
      add :min_age, :integer
      add :max_age, :integer
      add :capacity, :integer
      add :casual_booking_type, :string
      add :qk_room_id, :string
      add :service_id, references(:services, on_delete: :nothing)

      timestamps
    end
    create index(:rooms, [:service_id])
    create unique_index(:rooms, [:qk_room_id])
  end
end
