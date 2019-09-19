defmodule GothamWeb.UserController do
  use GothamWeb, :controller

  alias Gotham.Accounts
  alias Gotham.Times
  alias Gotham.Accounts.User

  alias Gotham.Auth.Guardian

  def sign_in(conn, %{"email" => email, "password" => password}) do
    case Accounts.token_sign_in(email, password) do
      {:ok, token, _claims} ->
        conn |> render("jwt.json", jwt: token)
        _ ->
          {:error, :unauthorized}
    end
  end

  def register(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Accounts.create_user(user_params), {:ok, token, _claims} <- Guardian.encode_and_sign(user) do
      conn |> render("jwt.json", jwt: token)
    end
  end

  action_fallback GothamWeb.FallbackController

  def authenticated_user(conn, _params) do
    user = Guardian.Plug.current_resource(conn)
    conn |> render("user.json", user: user)
  end

  def index(conn, _params) do
    users = Accounts.list_users()
    render(conn, "index.json", users: users)
  end

  def show(conn, %{"userID" => id}) do
    user = Accounts.get_user!(id)
    render(conn, "show.json", user: user)
  end

  def show_by_attr(conn, %{}) do
    params = conn.query_params

    # check that there an email and an username params
    if Map.has_key?(params, "email") and Map.has_key?(params, "username") do
      user = Accounts.get_user_by_attr!(Map.get(params, "email"), Map.get(params, "username")) # get the user by attributes
      render(conn, "show.json", user: user)
    end
  end

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Accounts.create_user(user_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.user_path(conn, :show, user))
      |> render("show.json", user: user)
    end
  end


  def update(conn, %{"userID" => id}) do
    user_params = conn.body_params
    user = Accounts.get_user!(id)

    with {:ok, %User{} = user} <- Accounts.update_user(user, user_params) do
      render(conn, "show.json", user: user)
    end
  end

  def delete(conn, %{"userID" => id}) do
    user = Accounts.get_user!(id)

    # call delete_all clocks and delete_all workingtimes
    Times.delete_clock_all_by_user(id)
    Times.delete_workingtime_all_by_user(id)

    # delete user
    with {:ok, %User{}} <- Accounts.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end
end
