defmodule TasktrackerWeb.TimeblockController do
  use TasktrackerWeb, :controller

  alias Tasktracker.Social
  alias Tasktracker.Social.Timeblock

  action_fallback TasktrackerWeb.FallbackController

  def index(conn, _params) do
    timeblocks = Social.list_timeblocks()

    render(conn, "index.json", timeblocks: timeblocks)
  end

  def create(conn, %{"timeblock" => timeblock_params, "context"=> context}) do
    with {:ok, %Timeblock{} = timeblock} <- Social.create_timeblock(timeblock_params) do
      if context == "html" do
          task = Social.get_task!(timeblock.task_id)
        conn

        |> redirect(to: page_path(conn, :timeblocks, task: task))
      else
        conn
        |> put_status(:created)
        |> put_resp_header("location", timeblock_path(conn, :show, timeblock))
        |> render("show.json", timeblock: timeblock)
      end
    end
  end

  def show(conn, %{"id" => id}) do
    timeblock = Social.get_timeblock!(id)

    render(conn, "show.json", timeblock: timeblock)
  end

  def update(conn, %{"id" => id, "timeblock" => timeblock_params, "context"=> context}) do
    timeblock = Social.get_timeblock!(id)
    task = Social.get_task!(timeblock.task_id)
    IO.inspect task
    with {:ok, %Timeblock{} = timeblock} <- Social.update_timeblock(timeblock, timeblock_params) do
      if context == "json" do
        render(conn, "show.json", timeblock: timeblock)
      else
        conn
        # |> put_flash(:info, "Task updated successfully.")
        |> redirect(to: page_path(conn, :timeblocks, task: task))

      end
    end
  end

  def delete(conn, %{"id" => id}) do
    timeblock = Social.get_timeblock!(id)
    with {:ok, %Timeblock{}} <- Social.delete_timeblock(timeblock) do
      send_resp(conn, :no_content, "")
    end
  end
end
