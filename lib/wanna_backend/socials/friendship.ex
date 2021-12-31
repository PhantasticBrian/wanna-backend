defmodule WannaBackend.Socials.Friendship do
  use Ecto.Schema
  import Ecto.Changeset

  schema "friendships" do
    field :accepted, :boolean, default: false
    field :from_user_id, :id
    field :to_user_id, :id

    timestamps()
  end

  @doc false
  def changeset(friendship, attrs) do
    friendship
    |> cast(attrs, [:accepted])
    |> validate_required([:accepted])
  end
end
