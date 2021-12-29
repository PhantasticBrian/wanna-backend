defmodule WannaBackend.Group do
  use Ecto.Schema
  import Ecto.Changeset

  schema "groups" do
    field :code, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(group, attrs) do
    group
    |> cast(attrs, [:name, :code])
    |> validate_required([:name, :code])
    |> unique_constraint(:code)
  end
end
