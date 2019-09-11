defmodule GothamWeb.WorkingtimeController do
  use GothamWeb, :controller

  alias Gotham.Times
  alias Gotham.Times.Workingtime

  action_fallback GothamWeb.FallbackController

  def create(conn, %{"userID" => id, "workingtime" => workingtime_params}) do
    with {:ok, %Workingtime{} = workingtime} <- Times.create_workingtime(workingtime_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.workingtime_path(conn, :show, id, workingtime))
      |> render("show.json", workingtime: workingtime)
    end
  end

  def show(conn, %{"userID" => id}) do
    workingtime = Times.get_workingtime!(id)
    render(conn, "show.json", workingtime: workingtime)
  end

  def show_by_attr(conn, %{"userID" => id}) do
    params = conn.query_params

    # check that there a start and a end params
    if Map.has_key?(params, "start") and Map.has_key?(params, "end") do
      workingtime = Times.get_workingtime_by_attr(id, Map.get(params, "start"), Map.get(params, "end")) # get the working time by attributes
      render(conn, "show.json", workingtime: workingtime)
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
