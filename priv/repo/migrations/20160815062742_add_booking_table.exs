defmodule InfoCare.Repo.Migrations.AddBookingTable do
  use Ecto.Migration

  def change do
    create table(:bookings) do
      add :ic_booking_id, :string
      add :start_time, :datetime
      add :end_time, :datetime
      add :date, :datetime
      add :parent_id, references(:parents, on_delete: :nothing)
      add :service_id, references(:services, on_delete: :nothing)
      add :child_id, references(:children, on_delete: :nothing)
      add :absent, :boolean
      timestamps
    end

    create index(:bookings, [:service_id, :parent_id, :child_id])
    create unique_index(:bookings, [:ic_booking_id])

  end
end
