defmodule KindynowQk.Repo.Migrations.CreateInitialTables do
  use Ecto.Migration

  def change do
    create table(:families) do
      add :qk_family_id, :string
      timestamps
    end

    create table(:contacts) do
      add :first_name, :string
      add :qk_contact_id, :string
      add :last_name, :string
      add :phone, :string
      add :account_relationship, :string
      add :family_id, references(:families, on_delete: :nothing)

      timestamps
    end

    create table(:children) do
      add :first_name, :string
      add :qk_child_id, :string
      add :last_name, :string
      add :dob, :date
      add :sync_id, :string
      add :family_id, references(:families, on_delete: :nothing)

      timestamps
    end

    create unique_index(:families, [:qk_family_id])
    create unique_index(:children, [:qk_child_id])
    create index(:children, [:family_id])
    create index(:contacts, [:family_id])
    create unique_index(:contacts, [:qk_contact_id])
  end
end
