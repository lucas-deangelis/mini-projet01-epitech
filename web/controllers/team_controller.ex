defmodule GothamWeb.TeamController do
  use GothamWeb, :controller

  alias Gotham.Accounts
  alias Gotham.Accounts.Team

  action_fallback GothamWeb.FallbackController

  def index(conn, _params) do
    teams = Accounts.list_teams()
    render(conn, "index.json", teams: teams)
  end

  def create(conn, %{"managerID" => managerId, "team" => team_params}) do
    manager = Accounts.get_user!(managerId)

    Map.put(team_params, :manager, manager)

    with {:ok, %Team{} = team} <- Accounts.create_team(team_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.team_path(conn, :show, team))
      |> render("show.json", team: team)
    end
  end

  def show(conn, %{"managerID" => managerId, "id" => id}) do
    team = Accounts.get_team!(id)
    render(conn, "show.json", team: team)
  end

  def show_manager_teams(conn, %{"managerID" => managerId}) do
    team = Accounts.get_teams_by_manager(managerId)
    render(conn, "show.json", team: team)
  end

  def update(conn, %{"managerID" => managerId, "id" => id, "team" => team_params}) do
    manager = Accounts.get_user!(managerId)
    team = Accounts.get_team!(id)

    Map.put(team_params, :manager, manager)

    with {:ok, %Team{} = team} <- Accounts.update_team(team, team_params) do
      render(conn, "show.json", team: team)
    end
  end

  def delete(conn, %{"id" => id}) do
    team = Accounts.get_team!(id)

    with {:ok, %Team{}} <- Accounts.delete_team(team) do
      send_resp(conn, :no_content, "")
    end
  end
end
