defmodule WannaBackend.Repo.Migrations.FriendshipsAddUniqueIndex do
  use Ecto.Migration

  def change do
    drop index(:friendships, [:from_user_id, :to_user_id])
    create index(:friendships, [:from_user_id, :to_user_id], unique: true)
  end
end
