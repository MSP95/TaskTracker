defmodule Tasktracker.Tracker.Track do
  use Ecto.Schema
  import Ecto.Changeset
  alias Tasktracker.Tracker.Track


  schema "tracks" do
    # field :user_id, :id
    # field :task_id, :id
    belongs_to :user, Tasktracker.Accounts.User
    belongs_to :task, Tasktracker.Social.Task
    timestamps()
  end

  @doc false
  def changeset(%Track{} = track, attrs) do
    track
    |> cast(attrs, [:user_id, :task_id])
    |> validate_required([:user_id, :task_id])
  end
end
