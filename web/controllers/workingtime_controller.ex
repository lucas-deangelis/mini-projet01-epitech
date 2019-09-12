defmodule GothamWeb.WorkingtimeController do
  use GothamWeb, :controller

  alias Gotham.Times
  alias Gotham.Times.Workingtime
  alias Gotham.Accounts

  action_fallback GothamWeb.FallbackController

  def createUsrId(conn, %{"userID" => id, "workingtime" => workingtime_params}) do
    user = Accounts.get_user!(id)

    with {:ok, %Workingtime{} = workingtime} <- Times.create_workingtime(user, workingtime_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.workingtime_path(conn, :show, id, workingtime))
      |> render("show.json", workingtime: workingtime)
    end
  end

  def show(conn, %{"userID" => userId, "workingtimeID" => workingtimeId}) do
    workingtime = Times.get_workingtime!(workingtimeId, userId)
    render(conn, "show.json", workingtime: workingtime)
  end

  def show_by_attr(conn, %{"userID" => id, "start" => start, "end" => endTime}) do
    params = conn.query_params

    # check that there a start and a end params
    if Map.has_key?(params, "start") and Map.has_key?(params, "end") do
        # Converting start parameter from iso to naivedatetime
        startTime = Map.get(params, "start")
        |> NaiveDateTime.from_iso8601!()

        # Converting end parameter from iso to naivedatetime
        endTime = Map.get(params, "end")
        |> NaiveDateTime.from_iso8601!()

         # get the working time by attributes
        workingtime = Times.get_workingtime_by_attr(id, startTime, endTime)
        render(conn, "index.json", workingtime: workingtime)
    end

  end

  def update(conn, %{"id" => id, "workingtime" => workingtime_params}) do
    workingtime = Times.get_workingtime!(id)

    with {:ok, %Workingtime{} = workingtime} <- Times.update_workingtime(workingtime, workingtime_params) do
      render(conn, "show.json", workingtime: workingtime)
    end
  end

  def delete(conn, %{"id" => id}) do
    workingtime = Times.get_workingtime!(id)

    with {:ok, %Workingtime{}} <- Times.delete_workingtime(workingtime) do
      send_resp(conn, :no_content, "")
    end
  end
end
