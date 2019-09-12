defmodule GothamWeb.ClockController do
  use GothamWeb, :controller

  alias Gotham.Times
  alias Gotham.Times.Clock
  alias Gotham.Accounts.User
  alias Gotham.Repo

  action_fallback GothamWeb.FallbackController

  def score(conn, %{"userID" => id}) do
    clock = Times.get_clock_by_user(id)
    IO.inspect(clock)
    user = Repo.get!(User, id)

    if not(is_nil(clock)) do
      # if clock.status is true (user is working), clock out (status = false) and record the work session
      if clock.status do
        IO.inspect("in clock status true")
        endTime = NaiveDateTime.utc_now()
        Times.create_workingtime(user, %{start: clock.time, end: endTime})
        IO.inspect("passed worktime creation")

        clock_params = %{time: endTime, status: false, user: id}
        Times.update_clock(clock, clock_params)

      # else initialise the work session and keep in memory the time of start
      else 
        IO.inspect("in clock status false")
        clock_params = %{time: NaiveDateTime.utc_now(), status: true, user: id}
        Times.update_clock(clock, clock_params)
      end
    # if clock doesn't exists, create clock
    else
      IO.inspect("inside is nil")
      clock_params = %{time: NaiveDateTime.utc_now(), status: true, user: id}
      with {:ok, %Clock{}} <- Times.create_clock(clock_params) do
        conn
        |> put_status(:created)
        |> put_resp_header("location", Routes.clock_path(conn, :show, id))
      end
    end 

    render(conn, "show.json", clock: clock)
  end

  def show(conn, %{"userID" => id}) do
    clock = Times.get_clock_by_user(id)
    render(conn, "show.json", clock: clock)
  end

end
