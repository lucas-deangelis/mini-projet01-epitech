defmodule GothamWeb.ClockController do
  use GothamWeb, :controller

  alias Gotham.Times
  alias Gotham.Times.Clock

  action_fallback GothamWeb.FallbackController

  def score(conn, %{"userID" => id, "clock" => clock_params}) do
    with {:ok, %Clock{} = clock} <- Times.create_clock(clock_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.clock_path(conn, :show, clock))
      |> render("show.json", clock: clock)
    end
  end

  def show(conn, %{"userID" => id}) do
    clock = Times.get_clock!(id)
    render(conn, "show.json", clock: clock)
  end

end
