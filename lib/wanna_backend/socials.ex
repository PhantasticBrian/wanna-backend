defmodule WannaBackend.Socials do
  @moduledoc """
  The Socials context.
  """

  import Ecto.Query, only: [from: 2]

  alias WannaBackend.Repo
  alias WannaBackend.Accounts.User
  alias WannaBackend.Socials.Friendship

  # def get_friends(user_id) do
  # end

  def get_friendships(user_id) do
    Repo.get(User, user_id)
    |> Repo.preload([friendships_from: :to_user, friendships_to: :from_user])
    |> Map.take([:friendships_from, :friendships_to])
  end

  def get_groups(user_id) do
    Repo.get(User, user_id)
    |> Ecto.assoc(:groups)
    |> Repo.all()
  end

  def create_friendship(user_id, friend_id) do
    matching_friendship = get_matching_friendship(user_id, friend_id)

    if matching_friendship do
      Friendship.changeset(matching_friendship, %{accepted: true} )
      |> Repo.update()
    end

    %Friendship{}
    |> Friendship.changeset(%{from_user_id: user_id, to_user_id: friend_id, accepted: !!matching_friendship})
    |> Repo.insert()
  end

  def remove_friendship(user_id, friend_id) do
    matching_friendship = get_matching_friendship(user_id, friend_id)

    if matching_friendship do
      Repo.delete(matching_friendship)
    end

    Repo.one(from f in Friendship,
    where: f.from_user_id == ^user_id and f.to_user_id == ^friend_id)
    |> Repo.delete()
  end

  def join_group(user_id, group_id, code) do

  end

  defp get_matching_friendship(user_id, friend_id) do
    Repo.one(from f in Friendship,
      where: f.from_user_id == ^friend_id and f.to_user_id == ^user_id)
  end

end
