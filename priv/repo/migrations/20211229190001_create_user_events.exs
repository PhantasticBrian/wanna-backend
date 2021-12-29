defmodule WannaBackend.Repo.Migrations.CreateUserEvents do
  use Ecto.Migration

  def change do
    create table(:user_events) do
      add :user_id, references(:users, on_delete: :nothing)
      add :event_id, references(:events, on_delete: :nothing)

      timestamps()
    end

    create index(:user_events, [:user_id])
    create index(:user_events, [:event_id])
  end
end
