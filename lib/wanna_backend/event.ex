defmodule WannaBackend.Event do
  use Ecto.Schema
  import Ecto.Changeset
  alias WannaBackend.Accounts.User

  schema "events" do
    field :address, :string
    field :end_time, :utc_datetime
    field :start_time, :utc_datetime
    field :title, :string
    field :owner_id, :id
    field :group_id, :id
    many_to_many :users, User, join_through: "user_events"

    timestamps()
  end

  @doc false
  def changeset(event, attrs) do
    event
    |> cast(attrs, [:title, :start_time, :end_time, :address])
    |> validate_required([:title])
  end
end
