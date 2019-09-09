defmodule GothamWeb.Router do
  use GothamWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", GothamWeb do
    pipe_through :api
  end
end
