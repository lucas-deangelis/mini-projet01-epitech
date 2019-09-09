defmodule GothamWeb.PageController do
  use GothamWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
