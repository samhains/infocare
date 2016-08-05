defmodule InfoCare.Repo.Migrations.CreateInitialTables do
  use Ecto.Migration

  def change do

    create table(:services) do
      add :ic_service_id, :string
      add :name, :string
      add :email, :string
      add :currency, :string
      add :licensed_capacity, :string
      add :phone_number, :string
      add :time_zone, :string
      add :street, :string
      add :suburb, :string
      add :state, :string
      add :country, :string
      add :post_code, :string
      timestamps
    end

    create table(:parents) do
      add :ic_parent_id, :string
      add :first_name, :string
      add :last_name, :string
      timestamps
    end

    create table(:children) do
      add :ic_child_id, :string
      add :first_name, :string
      add :last_name, :string
      add :dob, :string
      add :parent_id, references(:parents, on_delete: :nothing)
      add :service_id, references(:services, on_delete: :nothing)
      timestamps
    end

    create table(:rooms) do
      add :name, :string
      add :service_id, references(:services, on_delete: :nothing)
      timestamps
    end

    create table(:child_rooms) do
      add :room_id, references(:rooms, on_delete: :nothing)
      add :child_id, references(:children, on_delete: :nothing)
    end

    create index(:child_rooms, [:room_id])
    create index(:child_rooms, [:child_id])
    create index(:rooms, [:service_id])
    create unique_index(:services, [:ic_service_id])
    create unique_index(:children, [:ic_child_id])
    create index(:children, [:parent_id])
    create unique_index(:parents, [:ic_parent_id])
  end
end
