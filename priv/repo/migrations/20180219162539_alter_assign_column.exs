defmodule Tasktracker.Repo.Migrations.AddAssignField do
  use Ecto.Migration

  def change do
    alter table(:tasks) do
      add :assigned_id, references(:users, on_delete: :nilify_all),null: true
      add :user_id, references(:users, on_delete: :nilify_all),null: true
    end
  end
end
