defmodule WannaBackend.Socials.Friendship do
  use Ecto.Schema
  import Ecto.Changeset
  alias WannaBackend.Accounts.User

  @derive {Jason.Encoder, only: [:accepted, :from_user_id, :to_user_id, :inserted_at, :updated_at]}
  schema "friendships" do
    field :accepted, :boolean, default: false
    field :from_user_id, :id
    field :to_user_id, :id
    belongs_to :from_user, User, define_field: false
    belongs_to :to_user, User, define_field: false

    timestamps()
  end

  @doc false
  def changeset(friendship, attrs) do
    friendship
    |> cast(attrs, [:accepted, :from_user_id, :to_user_id])
    |> validate_required([:from_user_id, :to_user_id])
  end
end
