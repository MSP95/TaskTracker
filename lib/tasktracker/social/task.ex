defmodule Tasktracker.Social.Task do
  use Ecto.Schema
  import Ecto.Changeset
  alias Tasktracker.Social.Task


  schema "tasks" do
    field :completed, :boolean, default: false
    field :description, :string
    field :title, :string
    field :timetrack, :integer
    belongs_to :assigned, Tasktracker.Accounts.User, foreign_key: :assigned_id
    belongs_to :user, Tasktracker.Accounts.User, foreign_key: :user_id
    timestamps()
  end

  @doc false
  def changeset(%Task{} = task, attrs) do
    task
    |> cast(attrs, [:title, :description, :completed, :user_id, :assigned_id,:timetrack])
    |> validate_required([:title, :description, :completed,:timetrack])
    |> validate_change(:timetrack, fn :timetrack, minutes ->
      if rem(minutes, 15) == 0 do
        []
      else
        [timetrack: "Invalid time. Please Enter in 15 minute intervals"]
      end
    end)
  end
end
