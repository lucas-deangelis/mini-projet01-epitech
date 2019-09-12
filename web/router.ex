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
    plug CORSPlug, origin: "*"
    plug :accepts, ["json"]
  end

  scope "/", GothamWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  scope "/api", GothamWeb do
    pipe_through :api

    # User routes
  	get "/users", UserController, :show_by_attr
    get "/users/:userID", UserController, :show
    post "/users", UserController, :create
    put "/users/:userID", UserController, :update
    delete "/users/:userID", UserController, :delete

    # Working Time routes
    get "/workingtimes/:userID", WorkingtimeController, :show_by_attr
    get "/workingtimes/:userID/:workingtimeID", WorkingtimeController, :show
    post "/workingtimes/:userID", WorkingtimeController, :createUsrId
    post "/workingtimes", WorkingtimeController, :create # useful for testing purposes
    put "/workingtimes/:id", WorkingtimeController, :update
    delete "/workingtimes/:id", WorkingtimeController, :delete

    # Clocking routes
    get "/clocks/:userID", ClockController, :show
    post "/clocks/:userID", ClockController, :score # Manage departures and arrivals
  end
end
