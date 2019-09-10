defmodule GothamWeb.UserController do
  use GothamWeb, :controller

  alias Gotham.Accounts
  alias Gotham.Accounts.User

  action_fallback GothamWeb.FallbackController

  # def index(conn, _params) do
  #   users = Accounts.list_users()
  #   render(conn, "index.json", users: users)
  # end

  def show(conn, %{"userID" => id}) do
    user = Accounts.get_user!(id)
    render(conn, "show.json", user: user)
  end

  def show_all(conn, %{"userID" => id}) do
    user = Accounts.get_user!(id)
    render(conn, "show.json", user: user)
  end

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Accounts.create_user(user_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.user_path(conn, :show, user))
      |> render("show.json", user: user)
    end
  end

  def update(conn, %{"userID" => id, "user" => user_params}) do
    user = Accounts.get_user!(id)

    with {:ok, %User{} = user} <- Accounts.update_user(user, user_params) do
      render(conn, "show.json", user: user)
    end
  end

  def delete(conn, %{"userID" => id}) do
    user = Accounts.get_user!(id)

    with {:ok, %User{}} <- Accounts.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end
end
