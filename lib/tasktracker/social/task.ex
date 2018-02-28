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

    # has_one :client_manages, Manage, foreign_key: :client_id
    # has_many :manager_manages, Manage, foreign_key: :manager_id
    # has_many :clients, through: [:manager_manages, :client]
    # has_one :managers, through: [:client_manages, :manager]
    #
    # has_many :task_timeblocks, Manage, foreign_key: :task_id
    # has_many :timeblocks, through: [:task_timeblocks, :task_id]

  end

  @doc false
  def changeset(%Task{} = task, attrs) do
    task
    |> cast(attrs, [:title, :description, :completed, :creator_id, :assigned_id])
    |> validate_required([:title, :description, :completed])
    # |> validate_change(:timetrack, fn :timetrack, minutes ->
    #   if rem(minutes, 15) == 0 do
    #     []
    #   else
    #     [timetrack: "Invalid time. Please Enter in 15 minute intervals"]
    #   end
    # end)
  end
end
