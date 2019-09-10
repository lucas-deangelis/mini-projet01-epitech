defmodule GothamWeb.WorkingtimeController do
  use GothamWeb, :controller

  alias Gotham.Times
  alias Gotham.Times.Workingtime

  action_fallback GothamWeb.FallbackController

  def index(conn, _params) do
    workingtimes = Times.list_workingtimes()
    render(conn, "index.json", workingtimes: workingtimes)
  end

  def create(conn, %{"workingtime" => workingtime_params}) do
    with {:ok, %Workingtime{} = workingtime} <- Times.create_workingtime(workingtime_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.workingtime_path(conn, :show, workingtime))
      |> render("show.json", workingtime: workingtime)
    end
  end

  def show(conn, %{"id" => id}) do
    workingtime = Times.get_workingtime!(id)
    render(conn, "show.json", workingtime: workingtime)
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
