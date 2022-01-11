defmodule WannaBackendWeb.SocialChannel do
  use WannaBackendWeb, :channel
  alias WannaBackend.Socials

  # @impl true
  # def join("social:lobby", payload, socket) do
  #   if authorized?(payload) do
  #     {:ok, socket}
  #   else
  #     {:error, %{reason: "unauthorized"}}
  #   end
  # end

  @impl true
  def join("social:" <> user_id, payload, socket) do
    if authorized?(payload) do
      # events = Socials.get_friends(user_id)
      send(self(), :after_join)
      {:ok, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  @impl true
  def handle_info(:after_join, socket) do
    "social:" <> user_id = socket.topic
    push(socket, "friendships", Socials.get_friendships(user_id))
    {:noreply, socket}
  end

  def handle_in("friendships", _, socket) do
    "social:" <> user_id = socket.topic
    {:reply, {:ok, Socials.get_friendships(user_id)}, socket}
  end

  def handle_in("groups", _, socket) do
    "social:" <> user_id = socket.topic
    {:noreply, socket}
  end

  def handle_in("create:friendship", %{"friend_id" => friend_id}, socket) do
    "social:" <> user_id = socket.topic
    res = Socials.create_friendship(user_id, friend_id)
    {:reply, res, socket}
  end

  def handle_in("remove:friendship", %{"friend_id" => friend_id}, socket) do
    "social:" <> user_id = socket.topic
    res = Socials.remove_friendship(user_id, friend_id)
    {:reply, res, socket}
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  @impl true
  def handle_in("ping", payload, socket) do
    {:reply, {:ok, payload}, socket}
  end

  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (social:lobby).
  @impl true
  def handle_in("shout", payload, socket) do
    broadcast socket, "shout", payload
    {:noreply, socket}
  end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end
end
