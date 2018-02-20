defmodule TasktrackerWeb.TaskController do
  use TasktrackerWeb, :controller

  alias Tasktracker.Social
  alias Tasktracker.Social.Task
  alias Tasktracker.Accounts

  def new(conn, _params) do
    users = Accounts.list_users()
    changeset = Social.change_task(%Task{})
    render(conn, "new.html", users: users, changeset: changeset)
  end

  def create(conn, %{"task" => task}) do
    users = Accounts.list_users()
    current_user =  Integer.to_string(conn.assigns.current_user.id)
    task = Map.put(task, "user_id",current_user)
    task = Map.put(task, "timetrack","0")
    case Social.create_task(task) do
      {:ok, task} ->
        conn
        |> put_flash(:info, "Task created successfully.")
        |> redirect(to: page_path(conn, :feed))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset, users: users)
    end
  end

  def show(conn, %{"id" => id}) do
    task = Social.get_task!(id)
    render(conn, "show.html", task: task)
  end

  def edit(conn, %{"id" => id, "context" => context}) do
    users = Accounts.list_users()
    task = Social.get_task!(id)
    changeset = Social.change_task(task)
    case context do
      "assign" -> render(conn, "edit_assignee.html", task: task, changeset: changeset, users: users)
      "edit" -> render(conn, "edit.html", task: task, changeset: changeset, users: users)
      "status" -> render(conn, "edit_status.html", task: task, changeset: changeset)
      _ -> "do nothing"
    end
  end

  def update(conn, %{"id" => id, "task" => task_params}) do
    task = Social.get_task!(id)
    users = Accounts.list_users()
    case Social.update_task(task, task_params) do
      {:ok, task} ->
        conn
        |> put_flash(:info, "Task updated successfully.")
        |> redirect(to: page_path(conn, :feed))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", task: task, changeset: changeset, users: users)
    end
  end

  def delete(conn, %{"id" => id}) do
    task = Social.get_task!(id)
    {:ok, _task} = Social.delete_task(task)
    conn
    |> put_flash(:info, "Task deleted successfully.")
    |> redirect(to: page_path(conn, :feed))
  end
end
