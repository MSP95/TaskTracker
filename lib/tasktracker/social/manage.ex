defmodule Tasktracker.Social.Manage do
  use Ecto.Schema
  import Ecto.Changeset
  alias Tasktracker.Social.Manage
  alias Tasktracker.Accounts.User

  schema "manages" do

    belongs_to :client, User
    belongs_to :manager, User

    timestamps()
  end

  @doc false
  def changeset(%Manage{} = manage, attrs) do
    manage
    |> cast(attrs, [:client_id, :manager_id])
    |> validate_required([:client_id, :manager_id])
    |> unique_constraint(:client_id)
  end
end
