defmodule WannaBackendWeb.UserChannel do
  use WannaBackendWeb, :channel
  alias WannaBackend.Events

  @impl true
  def join("user:" <> user_id, payload, socket) do
    if authorized?(payload) do
      events = Events.get_events(user_id)
      |> Enum.map(fn (event) -> "event:#{event.id}" end)

      {:ok, socket
        |> assign(:events, [])
        |> put_new_events(events)}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  @impl true
  def handle_in("create_event", %{"event" => event, "invites" => invites}, socket) do
    result = Events.create(event, invites)
    if result[:ok] do
      {:ok, %{event: %{id: event_id}, user_event: {_, rows}}} = result
      Enum.map(rows, fn (row) -> row.user_id end)
      |> Events.notify_users(event_id)
    end
    {:reply, result, socket}
  end

  @impl true
  def handle_in("invite_event", %{"event_id" => event_id}, socket) do
    {:noreply, socket
    |> assign(:events, [])
    |> put_new_events(["event:#{event_id}"])}
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
        :ok = WannaBackendWeb.Endpoint.subscribe(event)
        assign(acc, :events, [event | events])
      end
    end)
  end
end
