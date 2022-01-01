defmodule WannaBackend.Socials do
  @moduledoc """
  The Socials context.
  """

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

  def add_friend(user_id, friend_id) do

  end

  def accept_friend(user_id, friend_id) do

  end

  def join_group(user_id, group_id, code) do

  end

end
