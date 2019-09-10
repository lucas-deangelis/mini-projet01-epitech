defmodule GothamWeb.ClockController do
  use GothamWeb, :controller

  alias Gotham.Times
  alias Gotham.Times.Clock
  alias Gotham.Accounts.User
  alias Gotham.Repo

  action_fallback GothamWeb.FallbackController

  def score(conn, %{"userID" => id}) do
    clock = Times.get_clock_by_user(id)

    # if clock in, create the clock data
    if is_nil(clock) do
      clock_params = %{time: NaiveDateTime.utc_now(), status: true, user: Repo.get!(User, id)}
      with {:ok, %Clock{}} <- Times.create_clock(clock_params) do
        conn
        |> put_status(:created)
        |> put_resp_header("location", Routes.clock_path(conn, :show, id))
      end
    else # else just update it
      IO.puts "coucou"
      clock_params = %{time: NaiveDateTime.utc_now(), status: false, user: Repo.get!(User, id)}
      Times.update_clock(clock, clock_params)
    end

    render(conn, "show.json", clock: clock)
  end

  def show(conn, %{"userID" => id}) do
    clock = Times.get_clock_by_user(id)
    render(conn, "show.json", clock: clock)
  end

end
