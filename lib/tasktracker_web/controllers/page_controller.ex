defmodule TasktrackerWeb.PageController do
  use TasktrackerWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
  def feed(conn, _params) do
    tasks = Tasktracker.Social.list_tasks()
    tracks = Tasktracker.Tracker.list_tracks()
    changeset = Tasktracker.Social.change_task(%Tasktracker.Social.Task{})
    render conn, "feed.html", tracks: tracks, tasks: tasks, changeset: changeset
  end
  def assignments(conn, _params) do

    tracks = Tasktracker.Tracker.list_tracks()
    changeset = Tasktracker.Social.change_task(%Tasktracker.Social.Task{})
    render conn, "assignments.html", tracks: tracks, changeset: changeset
  end

end
