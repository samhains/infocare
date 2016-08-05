defmodule InfoCare.Repo.Migrations.CreateBookingType do
  use Ecto.Migration

  def change do
    create table(:booking_types) do
      add :name, :string
      add :service_id, references(:services, on_delete: :nothing)

      timestamps
    end
    create index(:booking_types, [:service_id])

  end
end
