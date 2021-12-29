defmodule WannaBackend.UserEvent do
  use Ecto.Schema
  import Ecto.Changeset

  schema "user_events" do
    field :user_id, :id
    field :event_id, :id

    timestamps()
  end

  @doc false
  def changeset(user_event, attrs) do
    user_event
    |> cast(attrs, [])
    |> validate_required([])
  end
end
