defmodule InfoCare.Repo.Migrations.ChangeNameOfMaxColumnsAgain do
  use Ecto.Migration

  def change do
      alter table(:services) do
        remove :max_O2
        remove :max_U2
        add :max_o2, :integer
        add :max_u2, :integer
      end
  end
end
