defmodule TasktrackerWeb.TrackController do
  use TasktrackerWeb, :controller

  alias Tasktracker.Tracker
  alias Tasktracker.Tracker.Track

  def index(conn, _params) do
    tracks = Tracker.list_tracks()
    render(conn, "index.html", tracks: tracks)
  end

  def new(conn, %{"task" => task}) do
    users = Tasktracker.Accounts.list_users()

    changeset = Tracker.change_track(%Track{})
    render(conn, "new.html", users: users, changeset: changeset, task: task)
  end

  def create(conn, %{"track" => track_params}) do
    case Tracker.create_track(track_params) do
      {:ok, track} ->
        conn
        |> put_flash(:info, "Track created successfully.")
        |> redirect(to: page_path(conn, :feed))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    track = Tracker.get_track!(id)
    render(conn, "show.html", track: track)
  end

  def edit(conn, %{"id" => id}) do
    track = Tracker.get_track!(id)
    changeset = Tracker.change_track(track)
    render(conn, "edit.html", track: track, changeset: changeset)
  end

  def update(conn, %{"id" => id, "track" => track_params}) do
    track = Tracker.get_track!(id)

    case Tracker.update_track(track, track_params) do
      {:ok, track} ->
        conn
        |> put_flash(:info, "Track updated successfully.")
        |> redirect(to: track_path(conn, :show, track))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", track: track, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    track = Tracker.get_track!(id)
    {:ok, _track} = Tracker.delete_track(track)

    conn
    |> put_flash(:info, "Track deleted successfully.")
    |> redirect(to: track_path(conn, :index))
  end
end
