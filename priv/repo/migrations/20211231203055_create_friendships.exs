defmodule WannaBackend.Repo.Migrations.CreateFriendships do
  use Ecto.Migration

  def change do
    create table(:friendships) do
      add :accepted, :boolean, default: false, null: false
      add :from_user_id, references(:users, on_delete: :nothing)
      add :to_user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:friendships, [:from_user_id, :to_user_id])
  end
end
