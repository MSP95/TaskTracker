defmodule Tasktracker.Repo.Migrations.CreateTracks do
  use Ecto.Migration

  def change do
    create table(:tracks) do
      add :user_id, references(:users, on_delete: :nothing),null: false
      add :task_id, references(:tasks, on_delete: :delete_all),null: false

      timestamps()
    end

    create index(:tracks, [:user_id])
    create index(:tracks, [:task_id])
  end
end
