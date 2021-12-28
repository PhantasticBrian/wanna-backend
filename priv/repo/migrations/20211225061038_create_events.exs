defmodule WannaBackend.Repo.Migrations.CreateEvents do
  use Ecto.Migration

  def change do
    create table(:events) do
      add :title, :string
      add :start_time, :utc_datetime
      add :end_time, :utc_datetime
      add :address, :string
      add :owner_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:events, [:owner_id])
  end
end
