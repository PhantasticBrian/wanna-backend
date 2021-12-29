defmodule WannaBackend.Repo.Migrations.EventsAddGroupIdDolumn do
  use Ecto.Migration

  def change do
    alter table("events") do
      add :group_id, references(:groups, on_delete: :nothing)
    end
  end
end
