defmodule InfoCare.Repo.Migrations.AddOver2ToBooking do
  use Ecto.Migration

  def change do
    alter table(:bookings) do
      add :over_2, :boolean
    end
  end
end
