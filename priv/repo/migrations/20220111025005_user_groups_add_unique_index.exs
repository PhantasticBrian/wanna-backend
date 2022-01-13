defmodule WannaBackend.Repo.Migrations.UserGroupsAddUniqueIndex do
  use Ecto.Migration

  def change do
    create index(:user_groups, [:user_id, :group_id], unique: true)
  end
end
