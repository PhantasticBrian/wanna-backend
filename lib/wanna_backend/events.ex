defmodule WannaBackend.Events do
  @moduledoc """
  The Events context.
  """

  import Ecto.Query, warn: false
  alias WannaBackend.Repo

  alias WannaBackend.Event

  def create(event, invites) do
    %Event{}
    |> Event.changeset(event)
    |> Repo.insert()

    """
    for user in invites do
      Event.invite(event, user)
    end
    """
  end

  def invite(user_ids, event_id) do
    # TODO: check user presence
    for user_id <- user_ids do
      WannaBackend.Endpoint.broadcast! "user:" <> user_id, "invite_event", %{event_id: event_id}
    end
    #TODO: persist event invites
    #TODO: send push notification to users
  end

  def get_group_members(groups) do

  end

end
