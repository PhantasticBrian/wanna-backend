defmodule WannaBackend.Socials.Group do
  use Ecto.Schema
  import Ecto.Changeset

  alias WannaBackend.Accounts.User

  @derive {Jason.Encoder, only: [:code, :name]}
  schema "groups" do
    field :code, :string
    field :name, :string
    many_to_many :users, User, join_through: "user_groups"
    #TODO: add is_private field

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
