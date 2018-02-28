defmodule Tasktracker.Social do
  @moduledoc """
  The Social context.
  """

  import Ecto.Query, warn: false
  alias Tasktracker.Repo
  alias Tasktracker.Social.User
  alias Tasktracker.Social.Task
  alias Tasktracker.Accounts.User
  @doc """
  Returns the list of tasks.

  ## Examples

  iex> list_tasks()
  [%Task{}, ...]

  """
  def list_tasks do
    Repo.all(Task)
    |> Repo.preload(:creator)
    |> Repo.preload(:assigned)
  end

  def feed_tasks_for(user) do
    user = Repo.preload(user, :clients)
    client_ids = Enum.map(user.clients, &(&1.id))

    Repo.all(Task)
    |> Repo.preload(:assigned)
    |> Enum.filter(&(Enum.member?(client_ids, &1.assigned_id)))
    |> Repo.preload(:creator)
  end
  def get_clients(user) do
    user = Repo.preload(user, :clients)
    # clients_id = Enum.map(user.clients, &(&1.id))
    user.clients
  end
  def get_manager(user) do
    user = Repo.preload(user, :managers)
    # IO.inspect user.managers.id
    # Enum.map(user.managers, &(&1))
    user.managers
    # IO.inspect "finally"
    # Enum.map(user.manager, &(&1.id))
  end
  @doc """
  Gets a single task.

  Raises `Ecto.NoResultsError` if the Task does not exist.

  ## Examples

  iex> get_task!(123)
  %Task{}

  iex> get_task!(456)
  ** (Ecto.NoResultsError)

  """
  def get_task!(id) do
    Repo.get!(Task, id)
    |> Repo.preload(:creator)
    |> Repo.preload(:assigned)
  end

  @doc """
  Creates a task.

  ## Examples

  iex> create_task(%{field: value})
  {:ok, %Task{}}

  iex> create_task(%{field: bad_value})
  {:error, %Ecto.Changeset{}}

  """
  def create_task(attrs \\ %{}) do
    %Task{}
    |> Task.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a task.

  ## Examples

  iex> update_task(task, %{field: new_value})
  {:ok, %Task{}}

  iex> update_task(task, %{field: bad_value})
  {:error, %Ecto.Changeset{}}

  """
  def update_task(%Task{} = task, attrs) do

    task
    |> Task.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Task.

  ## Examples

  iex> delete_task(task)
  {:ok, %Task{}}

  iex> delete_task(task)
  {:error, %Ecto.Changeset{}}

  """
  def delete_task(%Task{} = task) do
    Repo.delete(task)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking task changes.

  ## Examples

  iex> change_task(task)
  %Ecto.Changeset{source: %Task{}}

  """
  def change_task(%Task{} = task) do
    Task.changeset(task, %{})
  end

  alias Tasktracker.Social.Manage

  @doc """
  Returns the list of manages.

  ## Examples

  iex> list_manages()
  [%Manage{}, ...]

  """
  def list_manages do
    Repo.all(Manage)
  end

  @doc """
  Gets a single manage.

  Raises `Ecto.NoResultsError` if the Manage does not exist.

  ## Examples

  iex> get_manage!(123)
  %Manage{}

  iex> get_manage!(456)
  ** (Ecto.NoResultsError)

  """
  def get_manage!(id), do: Repo.get!(Manage, id)

  @doc """
  Creates a manage.

  ## Examples

  iex> create_manage(%{field: value})
  {:ok, %Manage{}}

  iex> create_manage(%{field: bad_value})
  {:error, %Ecto.Changeset{}}

  """
  def create_manage(attrs \\ %{}) do
    %Manage{}
    |> Manage.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a manage.

  ## Examples

  iex> update_manage(manage, %{field: new_value})
  {:ok, %Manage{}}

  iex> update_manage(manage, %{field: bad_value})
  {:error, %Ecto.Changeset{}}

  """
  def update_manage(%Manage{} = manage, attrs) do
    manage
    |> Manage.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Manage.

  ## Examples

  iex> delete_manage(manage)
  {:ok, %Manage{}}

  iex> delete_manage(manage)
  {:error, %Ecto.Changeset{}}

  """
  def delete_manage(%Manage{} = manage) do
    Repo.delete(manage)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking manage changes.

  ## Examples

  iex> change_manage(manage)
  %Ecto.Changeset{source: %Manage{}}

  """
  def change_manage(%Manage{} = manage) do
    Manage.changeset(manage, %{})
  end

  def manages_map_for(user_id) do
    Repo.all(from f in Manage,
    where: f.manager_id == ^user_id)
    |> Enum.map(&({&1.client_id, &1.id}))
    |> Enum.into(%{})
  end



  alias Tasktracker.Social.Timeblock

  @doc """
  Returns the list of timeblocks.

  ## Examples

  iex> list_timeblocks()
  [%Timeblock{}, ...]

  """
  def list_timeblocks do
    Repo.all(Timeblock)
    |> Repo.preload(:user)

  end

  @doc """
  Gets a single timeblock.

  Raises `Ecto.NoResultsError` if the Timeblock does not exist.

  ## Examples

  iex> get_timeblock!(123)
  %Timeblock{}

  iex> get_timeblock!(456)
  ** (Ecto.NoResultsError)

  """
  def get_my_timeblock(taskid, userid)do

    blocklist = Repo.all(from f in Timeblock,
    where: f.task_id == ^taskid and f.user_id == ^userid and f.end_time == "-")
    if Enum.empty?(blocklist) do
      timeblock = %{"blockid"=> ""}
    else
      timeblock = Enum.map(blocklist, &({"blockid", &1.id})) |> Enum.into(%{})
    end
    timeblock


  end
  def get_timeblock!(id) do
    Repo.get!(Timeblock, id)
    |> Repo.preload(:task)
  end

  @doc """
  Creates a timeblock.

  ## Examples

  iex> create_timeblock(%{field: value})
  {:ok, %Timeblock{}}

  iex> create_timeblock(%{field: bad_value})
  {:error, %Ecto.Changeset{}}

  """
  def create_timeblock(attrs \\ %{}) do
    %Timeblock{}
    |> Timeblock.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a timeblock.

  ## Examples

  iex> update_timeblock(timeblock, %{field: new_value})
  {:ok, %Timeblock{}}

  iex> update_timeblock(timeblock, %{field: bad_value})
  {:error, %Ecto.Changeset{}}

  """
  def update_timeblock(%Timeblock{} = timeblock, attrs) do
    timeblock
    |> Timeblock.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Timeblock.

  ## Examples

  iex> delete_timeblock(timeblock)
  {:ok, %Timeblock{}}

  iex> delete_timeblock(timeblock)
  {:error, %Ecto.Changeset{}}

  """
  def delete_timeblock(%Timeblock{} = timeblock) do
    Repo.delete(timeblock)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking timeblock changes.

  ## Examples

  iex> change_timeblock(timeblock)
  %Ecto.Changeset{source: %Timeblock{}}

  """
  def change_timeblock(%Timeblock{} = timeblock) do
    Timeblock.changeset(timeblock, %{})
  end
end
