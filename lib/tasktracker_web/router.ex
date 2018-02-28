defmodule TasktrackerWeb.Router do
  use TasktrackerWeb, :router
  # import TasktrackerWebAddOn

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug TasktrackerWebAddOn
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", TasktrackerWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index

    resources "/users", UserController
    resources "/tasks", TaskController
    post "/session", SessionController, :create
    delete "/session", SessionController, :delete
    get "/profile", PageController, :profile
    get "/feed", PageController, :feed
    get "/taskreport", PageController, :taskreport
    get "/editblock", PageController, :editblock
    get "/timeblocks", PageController, :timeblocks
    get "/assignments", PageController, :assignments
  end

  # Other scopes may use custom stacks.
  scope "/api/v1", TasktrackerWeb do
    pipe_through :api
    resources "/timeblocks", TimeblockController, except: [:new, :edit]
    resources "/manages", ManageController, except: [:new, :edit]
  end
end
