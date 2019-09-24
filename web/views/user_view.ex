defmodule GothamWeb.UserView do
  use GothamWeb, :view
  alias GothamWeb.UserView

  def render("index.json", %{users: users}) d
    %{data: render_many(users, UserView, "user_preloaded.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{id: user.id,
      username: user.username,
      email: user.email,
      role: user.role,
    }
  end

  def render("user_preloaded.json", %{user: user}) do
    %{
      id: user.id,
      username: user.username,
      email: user.email,
      role: user.role,
      teams: user.teams,
      clock: user.clock,
      workingtimes: user.workingtimes
    }
  end

  def render("jwt.json", %{jwt: jwt}) do
    %{jwt: jwt}
  end
end
