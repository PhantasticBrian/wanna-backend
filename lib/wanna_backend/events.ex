defmodule WannaBackend.Events do
  @moduledoc """
  The Events context.
  """

  import Ecto.Query, warn: false
  alias Ecto.Multi

  alias WannaBackend.Repo
  alias WannaBackend.Event
  alias WannaBackend.UserEvent

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

  def notify_users(invites) do
    #TODO: check user presence
    for user_id <- invites do
      WannaBackend.Endpoint.broadcast! "user:" <> user_id, "invite_event", %{event_id: 1}
      #TODO: send push notification to users
    end
  end


  def get_group_members(groups) do

  end

end
