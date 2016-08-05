defmodule InfoCare.Repo.Migrations.AddFieldsToBooking do
  use Ecto.Migration

  def change do
    alter table(:bookings) do
      add :reminder_time, :datetime
      add :expiry_time, :datetime
      add :reminder_send, :boolean
      add :absent, :boolean
      add :rebooked, :boolean
      add :utilisation, :string
      add :day_status, :string
      add :permanent_booking, :string
    end
  end
end
