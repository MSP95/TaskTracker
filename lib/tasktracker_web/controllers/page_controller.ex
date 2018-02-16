defmodule TasktrackerWeb.PageController do
  use TasktrackerWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
  def feed(conn, _params) do
    tasks = Tasktracker.Social.list_tasks()
    changeset = Tasktracker.Social.change_task(%Tasktracker.Social.Task{})
    render conn, "feed.html", tasks: tasks, changeset: changeset
  end

end
