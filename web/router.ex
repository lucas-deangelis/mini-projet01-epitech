defmodule GothamWeb.Router do
  use GothamWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", GothamWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  scope "/api", GothamWeb do
    pipe_through :api

    # User routes
    scope "/users" do
      get "/", UserController, :show_by_attr
      get "/:userID", UserController, :show
      post "/", UserController, :create
      put "/:userID", UserController, :update
      delete "/:userID", UserController, :delete

    end

    # Team - User nested routes
    scope "/users/:managerID/teams" do
      get "/", TeamController, :show
      post "/", TeamController, :create
    end

    # Teams routes
    scope "/teams" do
      get "/", TeamController, :index
      put "/:id", TeamController, :update
      delete "/:id", TeamController, :delete
    end

    # Working Time routes
    get "/workingtimes/:userID", WorkingtimeController, :show_by_attr
    get "/workingtimes/:userID/:workingtimeID", WorkingtimeController, :show
    post "/workingtimes/:userID", WorkingtimeController, :createUsrId
    post "/workingtimes", WorkingtimeController, :create
    put "/workingtimes/:id", WorkingtimeController, :update
    delete "/workingtimes/:id", WorkingtimeController, :delete

    # Clocking routes
    get "/clocks/:userID", ClockController, :show
    post "/clocks/:userID", ClockController, :score # Manage departures and arrivals

  end
end
