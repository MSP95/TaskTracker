defmodule Tasktracker.Social.Timeblock do
  use Ecto.Schema
  import Ecto.Changeset
  alias Tasktracker.Social.Timeblock
  alias Tasktracker.Accounts.User
  alias Tasktracker.Social.Task

  schema "timeblocks" do
    field :end_time, :string
    field :start_time, :string
    belongs_to :task, Task, foreign_key: :task_id
    belongs_to :user, User, foreign_key: :user_id

    timestamps()
  end

  @doc false
  def changeset(%Timeblock{} = timeblock, attrs) do
    timeblock
    |> cast(attrs, [:start_time, :end_time, :task_id, :user_id])
    |> validate_required([:start_time, :end_time])
  end
end
