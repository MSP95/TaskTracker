defmodule TasktrackerWeb.PageController do
  use TasktrackerWeb, :controller

  alias Tasktracker.Social
  alias Tasktracker.Accounts
  alias Tasktracker.Accounts.User
  def index(conn, _params) do
    render conn, "index.html"
  end

  def feed(conn, _params) do
    tasks = Tasktracker.Social.list_tasks()
    changeset = Tasktracker.Social.change_task(%Tasktracker.Social.Task{})
    render conn, "feed.html", tasks: tasks, changeset: changeset
  end

  def assignments(conn, _params) do

    tasks = Tasktracker.Social.list_tasks()
    changeset = Tasktracker.Social.change_task(%Tasktracker.Social.Task{})
    render conn, "assignments.html", tasks: tasks, changeset: changeset
  end
  def profile(conn,_params) do
    current_user = conn.assigns[:current_user]
    users = Accounts.list_users()
    manages = Social.manages_map_for(current_user.id)
    curruser = Accounts.get_user!(current_user.id)

    manager = Social.get_manager(curruser)
    render(conn, "profile.html", users: users, manager: manager, manages: manages)
  end
  def taskreport(conn, _params) do
    current_user = conn.assigns[:current_user]
    tasks = Social.feed_tasks_for(current_user)
    # tasks = Tasktracker.Social.list_tasks()
    changeset = Tasktracker.Social.change_task(%Tasktracker.Social.Task{})
    render conn, "task_report.html", tasks: tasks, changeset: changeset
  end


  def editblock(conn, %{"block" => block}) do
    block0 = Social.get_timeblock!(block);

    changeset = Social.change_timeblock(block0)

    render conn, "block_edit.html", block: block, changeset: changeset
  end


  def timeblocks(conn, %{"task" => task}) do
    # IO.inspect task
    current_user = conn.assigns[:current_user]
    timeblock = Social.get_my_timeblock(task, current_user.id)
    timeblocks = Social.list_timeblocks()
    changeset = Social.change_timeblock(%Tasktracker.Social.Timeblock{})
    task = Social.get_task!(task)
    render(conn, "timeblock.html", task: task, timeblock: timeblock, timeblocks: timeblocks,  changeset: changeset)
  end
end
