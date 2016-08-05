defmodule InfoCare.Repo.Migrations.CreateService do
  use Ecto.Migration

  def change do
    create table(:services) do
      add :qk_service_id, :string
      add :name, :string
      add :email, :string
      add :phone_number, :string
      add :time_zone, :string
      add :licensed_capacity, :string
      add :street, :string
      add :suburb, :string
      add :state, :string
      add :post_code, :string

      timestamps
    end

    create unique_index(:services, [:qk_service_id])
  end
end
