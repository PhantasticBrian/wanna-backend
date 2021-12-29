defmodule WannaBackend.UserGroup do
  use Ecto.Schema
  import Ecto.Changeset

  schema "user_groups" do
    field :user_id, :id
    field :group_id, :id

    timestamps()
  end

  @doc false
  def changeset(user_group, attrs) do
    user_group
    |> cast(attrs, [])
    |> validate_required([])
  end
end
