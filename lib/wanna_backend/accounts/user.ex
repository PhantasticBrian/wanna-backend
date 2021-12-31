defmodule WannaBackend.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias WannaBackend.Event

  schema "users" do
    field :first_name, :string
    field :last_name, :string
    field :username, :string
    many_to_many :events, Event, join_through: "user_events"
    many_to_many :friends, User,
      join_through: "friendships",
      join_keys: [from_user_id: :id, to_user_id: :id]

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:first_name, :last_name, :username])
    |> validate_required([:first_name, :last_name, :username])
  end
end
