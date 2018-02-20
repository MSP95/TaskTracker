defmodule Tasktracker.Repo.Migrations.CreateTasks do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string, null: false
      timestamps()
    end
    create unique_index(:users, [:name])
    create table(:tasks) do
      add :title, :string, null: false
      add :description, :text,null: false
      add :assigned_id, references(:users, on_delete: :nilify_all),null: true
      add :user_id, references(:users, on_delete: :nilify_all),null: true
      add :completed, :boolean, default: false, null: false
      timestamps()
    end
  end
end
