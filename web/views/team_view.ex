defmodule GothamWeb.TeamView do
  use GothamWeb, :view
  alias GothamWeb.TeamView

  def render("index.json", %{teams: teams}) do
    %{data: render_many(teams, TeamView, "team.json")}
  end

  def render("show.json", %{team: team}) do
    %{data: render_one(team, TeamView, "team.json")}
  end

  def render("team.json", %{team: team}) do
    %{
      name: team.name,
      manager: team.manager,
      users: team.users
    }
  end

  def render("members.json", %{users: users}) do
    %{data: render_many(users, TeamView, "team.json")}
  end

end
