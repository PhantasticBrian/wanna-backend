defmodule WannaBackend.Repo.Migrations.GroupsAddCodeNonNullConstraint do
  use Ecto.Migration

  def change do
    alter table(:groups) do
      modify(:code, :string, null: false)
    end
  end
end
