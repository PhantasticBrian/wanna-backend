defmodule WannaBackendWeb.UserChannel do
  use WannaBackendWeb, :channel
  alias WannaBackend.Events

  @impl true
  def join("user:" <> user_id, payload, socket) do
    # if authorized?(payload) do
    #   {:ok, socket}
    # else
    #   {:error, %{reason: "unauthorized"}}
    # end
    events = ["test1", "test2"] # TODO: get events from db

    {:ok, socket
      |> assign(:events, [])
      |> put_new_events(events)}
  end

  @impl true
  # def handle_in("create_event", %{"id" => id, "owner_id" => owner_id, "title" => title, "start" => start, "address" => address, "geolocation" => geolocation}, socket) do
  def handle_in("create_event", %{"event" => event, "invites" => invites}, socket) do
    # Call Events.create_event(payload)
    result = Events.create_event(event, invites)
    if result[:ok] do
      {:ok, %{event: _, user_event: {_, rows}}} = result
      Enum.map(rows, fn (row) -> row.user_id end)
      |> Event.notify_users(result[:user_event])
    end
    {:reply, result, socket}
  end

  @impl true
  def handle_in("invite_event", %{"event_id" => event_id}, socket) do
    {:noreply, socket
    |> assign(:events, [])
    |> put_new_events([event_id])}
  end

  @impl true
  def handle_in("update_invite_status", payload, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_in("update_event", payload, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_in("join_chat", payload, socket) do
    {:ok, socket}
  end


  @impl true
  def handle_in("send_chat", payload, socket) do
    {:ok, socket}
  end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end

  defp put_new_events(socket, events) do
    Enum.reduce(events, socket, fn event, acc ->
      events = acc.assigns.events
      if event in events do
        acc
      else
        :ok = WannaBackend.Endpoint.subscribe(event)
        assign(acc, :events, [event | events])
        #TODO: load persisted event data
      end
    end)
  end
end
