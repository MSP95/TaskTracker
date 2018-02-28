defmodule Tasktracker.Social.Task do
  use Ecto.Schema
  import Ecto.Changeset
  alias Tasktracker.Social.Task


  schema "tasks" do
    field :completed, :boolean, default: false
    field :description, :string
    field :title, :string
    belongs_to :assigned, Tasktracker.Accounts.User, foreign_key: :assigned_id
    belongs_to :creator, Tasktracker.Accounts.User, foreign_key: :creator_id
    timestamps()



  end

  @doc false
  def changeset(%Task{} = task, attrs) do
    task
    |> cast(attrs, [:title, :description, :completed, :creator_id, :assigned_id])
    |> validate_required([:title, :description, :completed])

  end
end
