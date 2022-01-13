defmodule WannaBackend.Socials.UserGroup do
  use Ecto.Schema
  import Ecto.Changeset

  alias WannaBackend.Accounts.User
  alias WannaBackend.Socials.Group

  @derive {Jason.Encoder, only: [:user_id, :group_id]}
  schema "user_groups" do
    # field :user_id, :id
    # field :group_id, :id
    belongs_to :user, User
    belongs_to :group, Group
    #TODO: add ownership

    timestamps()
  end

  def changeset(user_group, attrs) do
    user_group
    |> cast(attrs, [:user_id, :group_id])
    |> validate_required([:user_id, :group_id])
    |> unique_constraint([:user_id, :group_id])
  end
end
