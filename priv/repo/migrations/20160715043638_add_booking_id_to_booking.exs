defmodule InfoCare.Repo.Migrations.AddBookingIdToBooking do
  use Ecto.Migration

  def change do
    alter table(:bookings) do
      add :qk_booking_id, :string
    end

    create unique_index(:bookings, [:qk_booking_id])
  end
end
