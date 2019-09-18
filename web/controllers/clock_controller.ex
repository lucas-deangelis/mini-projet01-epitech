defmodule GothamWeb.ClockController do
  use GothamWeb, :controller

  alias Gotham.Times
  alias Gotham.Times.Clock
  alias Gotham.Accounts.User
  alias Gotham.Repo

  action_fallback GothamWeb.FallbackController

  def score(conn, %{"userID" => id}) do
    clock = Times.get_clock_by_user(id)
    user = Repo.get!(User, id)

    if !is_nil(clock) do
      # if clock.status is true (user is working), clock out (status = false) and record the work session
      if clock.status do
        endTime = NaiveDateTime.utc_now()
        Times.create_workingtime(%{start: clock.time, end: endTime}, user)

        clock_params = %{time: endTime, status: false}
        Times.update_clock(clock, clock_params)

      # else initialise the work session and keep in memory the time of start
      else
        clock_params = %{time: NaiveDateTime.utc_now(), status: true}
        Times.update_clock(clock, clock_params)
      end
    # if clock doesn't exists, create clock
    else
      clock_params = %{time: NaiveDateTime.utc_now(), status: true}
      with {:ok, %Clock{} = clock} <- Times.create_clock(clock_params, user) do
        conn
        |> put_status(:created)
        |> put_resp_header("location", Routes.clock_path(conn, :show, id))
        |> render("show.json", clock: clock)
      end
    end

    render(conn, "show.json", clock: clock)
  end

  def show(conn, %{"userID" => id}) do
    clock = Times.get_clock_by_user(id)
    render(conn, "show.json", clock: clock)
  end

end
