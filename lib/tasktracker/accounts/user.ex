
defmodule Tasktracker.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Tasktracker.Accounts.User
  alias Tasktracker.Social.Manage

  schema "users" do
    field :name, :string
    has_one :client_manages, Manage, foreign_key: :client_id
    has_many :manager_manages, Manage, foreign_key: :manager_id
    has_many :clients, through: [:manager_manages, :client]
    has_one :managers, through: [:client_manages, :manager]

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> unique_constraint(:name)
  end
end
