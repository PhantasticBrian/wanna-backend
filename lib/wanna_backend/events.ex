defmodule WannaBackend.Events do
  @moduledoc """
  The Events context.
  """

  import Ecto.Query, warn: false
  alias Ecto.Query
  alias Ecto.Multi

  alias WannaBackend.Repo
  alias WannaBackend.Accounts.User
  alias WannaBackend.Event
  alias WannaBackend.UserEvent

  def get_events(user_id, limit \\ 20) do
    Repo.get(User, user_id)
    |> Ecto.assoc(:events)
    |> Query.limit(^limit)
    |> Repo.all()
  end

  def create(event, invites) do
    Multi.new()
    |> Multi.insert(:event, Event.changeset(%Event{}, event))
    |> Multi.insert_all(:user_event, UserEvent,
      fn %{
        event: %Event{
          id: event_id
          #TODO: add invites based on group_id
        }
      } ->
        timestamp = NaiveDateTime.utc_now() |> NaiveDateTime.truncate(:second)
        Enum.map(invites, fn (invite) ->
          %{
            user_id: invite,
            event_id: event_id,
            inserted_at: timestamp,
            updated_at: timestamp
          }
        end)
      end,
      returning: true
    )
    |> Repo.transaction()
  end

  def notify_users(invites, event_id) do
    #TODO: check user presence
    for user_id <- invites do
      WannaBackendWeb.Endpoint.broadcast! "user:" <> user_id, "invite_event", %{event_id: event_id}
      #TODO: send push notification to users
    end
  end


  def get_group_members(groups) do

  end

end
