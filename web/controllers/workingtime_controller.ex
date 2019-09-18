defmodule GothamWeb.WorkingtimeController do
  use GothamWeb, :controller

  alias Gotham.Times
  alias Gotham.Times.Workingtime
  alias Gotham.Accounts

  action_fallback GothamWeb.FallbackController

  def createUsrId(conn, %{"userID" => id, "workingtime" => workingtime_params}) do
    user = Accounts.get_user!(id)

    with {:ok, %Workingtime{} = workingtime} <- Times.create_workingtime(workingtime_params, user) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.workingtime_path(conn, :show, id, workingtime))
      |> render("show.json", workingtime: workingtime)
    end
  end

  def update(conn, %{"id" => id, "workingtime" => workingtime_params}) do
    workingtime = Times.get_workingtime!(id)

    with {:ok, %Workingtime{} = workingtime} <- Times.update_workingtime(workingtime, workingtime_params) do
      render(conn, "show.json", workingtime: workingtime)
    end
  end

  def show(conn, %{"userID" => userId, "workingtimeID" => workingtimeId}) do
    workingtime = Times.get_workingtimeUser!(workingtimeId, userId)
    render(conn, "show.json", workingtime: workingtime)
  end

  def show_by_attr(conn, %{"userID" => id, "start" => startTime, "end" => endTime}) do
    params = conn.query_params

    startTime = nil
    endTime = nil

    # check that there a start params that is not null and not empty
    if Map.has_key?(params, "start") and !is_nil(Map.get(params, "start")) and !String.equivalent?(Map.get(params, "start"), '')  do
      # Converting start parameter from iso to naivedatetime
      startTime = Map.get(params, "start")
      |> NaiveDateTime.from_iso8601!()
    end

    # check that there an end params that is not null and not empty
    if Map.has_key?(params, "end") and !is_nil(Map.get(params, "end")) and !String.equivalent?(Map.get(params, "end"), '')  do
      # Converting end parameter from iso to naivedatetime
      endTime = Map.get(params, "end")
      |> NaiveDateTime.from_iso8601!()
    end

    # get the working time by attributes
    workingtime = Times.get_workingtime_by_attr(id, startTime, endTime)
    render(conn, "index.json", workingtime: workingtime)

  end


  def delete(conn, %{"id" => id}) do
    workingtime = Times.get_workingtime!(id)

    with {:ok, %Workingtime{}} <- Times.delete_workingtime(workingtime) do
      send_resp(conn, :no_content, "")
    end
  end

end
