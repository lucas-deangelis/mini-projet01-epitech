defmodule GothamWeb.TeamController do
  use GothamWeb, :controller

  alias Gotham.Accounts
  alias Gotham.Accounts.{User, UserTeam, Team}

  action_fallback GothamWeb.FallbackController

  def index(conn, _params) do
    teams = Accounts.list_teams()
    render(conn, "index.json", teams: teams)
  end

  def create(conn, %{"managerID" => managerId}) do
    team_params = conn.body_params
    manager = Accounts.get_user!(managerId)

    with {:ok, %Team{} = team} <- Accounts.create_team(team_params, manager) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.team_path(conn, :show, managerId, team))
      |> render("show.json", team: team)
    end
  end

  def show(conn, %{"managerID" => managerId, "id" => id}) do
    team = Accounts.get_team!(id)
    render(conn, "show.json", team: team)
  end

  def show_manager_teams(conn, %{"managerID" => managerId}) do
    team = Accounts.get_teams_by_manager(managerId)
    render(conn, "index.json", teams: team)
  end

  def update(conn, %{"id" => id}) do
    team_params = conn.body_params
    team = Accounts.get_team!(id)

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

  def show_team_members(conn, %{"id" => teamId}) do
    users = Accounts.get_team_members(teamId)
    render(conn, "members.json", users: users)
  end

  def delete_team_member(conn, %{"teamId" => teamId, "userId" => userId}) do
    with {:ok, %UserTeam{}} <- Accounts.delete_user_from_team(teamId, userId) do
      send_resp(conn, :no_content, "")
    end
  end

  def add_team_member(conn, %{"teamId" => teamId, "userId" => userId}) do
    with {:ok, %UserTeam{} = user_team} <- Accounts.add_user_in_team(teamId, userId) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.team_path(conn, :add_team_member, teamId, userId))
      |> render("show_user_team.json", user_team: user_team)
    end
  end
end
