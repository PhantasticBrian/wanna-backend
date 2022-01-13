defmodule WannaBackend.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias WannaBackend.Accounts.User
  alias WannaBackend.Event
  alias WannaBackend.Socials.{Group, Friendship}

  @derive {Jason.Encoder, only: [:first_name, :last_name, :username]}
  schema "users" do
    field :first_name, :string
    field :last_name, :string
    field :username, :string
    has_many :friendships_from, Friendship, foreign_key: :from_user_id
    has_many :friendships_to, Friendship, foreign_key: :to_user_id
    many_to_many :friends_from, User,
      join_through: "friendships",
      join_keys: [from_user_id: :id, to_user_id: :id]
    many_to_many :friends_to, User,
      join_through: "friendships",
      join_keys: [to_user_id: :id, from_user_id: :id]
    many_to_many :events, Event, join_through: "user_events"
    many_to_many :groups, Group, join_through: "user_groups"

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:first_name, :last_name, :username])
    |> validate_required([:first_name, :last_name, :username])
  end
end
