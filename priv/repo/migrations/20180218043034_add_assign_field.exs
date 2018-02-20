defmodule Tasktracker.Repo.Migrations.AddAssignField do
  use Ecto.Migration

  def change do
    alter table(:tasks) do
      add :assigned_id, references(:users, on_delete: :nothing),null: true
    end
  end
end
