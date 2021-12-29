defmodule WannaBackend.Repo.Migrations.CreateGroups do
  use Ecto.Migration

  def change do
    create table(:groups) do
      add :name, :string
      add :code, :string

      timestamps()
    end

    create unique_index(:groups, [:code])
  end
end
