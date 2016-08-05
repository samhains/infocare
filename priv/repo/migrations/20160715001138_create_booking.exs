defmodule InfoCare.Repo.Migrations.CreateBooking do
  use Ecto.Migration

  def change do
    create table(:bookings) do
      add :date, :datetime
      add :fee, :integer
      add :start_time, :datetime
      add :end_time, :datetime
      add :service_id, references(:services, on_delete: :nothing)
      add :contact_id, references(:contacts, on_delete: :nothing)
      add :child_id, references(:children, on_delete: :nothing)
      add :room_id, references(:rooms, on_delete: :nothing)
      add :booking_type_id, references(:booking_types, on_delete: :nothing)

      timestamps
    end
    create index(:bookings, [:service_id])
    create index(:bookings, [:contact_id])
    create index(:bookings, [:child_id])
    create index(:bookings, [:room_id])
    create index(:bookings, [:booking_type_id])

  end
end
