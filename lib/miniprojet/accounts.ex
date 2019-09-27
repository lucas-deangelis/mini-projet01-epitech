defmodule Gotham.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias Gotham.Repo

  alias Gotham.Accounts.User
  alias Gotham.Accounts.Team

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_users do
    Repo.all(User) |> Repo.preload(:teams)
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id) do
    Repo.get!(User, id)
  end

  @doc """
  Gets a single user with his associations.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user_preloaded!(123)
      %User{}

      iex> get_user_preloaded!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user_preloaded!(id) do
    Repo.get!(User, id) |> Repo.preload(:clock) |> Repo.preload(:teams) |> Repo.preload(:workingtimes)
  end

  @doc """
  Gets a single user by attributes.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user_by_attr!("mathieu.dufour@epitech.eu", "mdufour")
      %User{}

      iex> get_user_by_attr!("toto@yopmail.com", "nobody")
      ** (Ecto.NoResultsError)

  """
  def get_user_by_attr!(email, username) do
    Repo.get_by!(User, [email: email, username: username])
  end

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a User.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{source: %User{}}

  """
  def change_user(%User{} = user) do
    User.changeset(user, %{})
  end

  @doc """
  Returns the list of teams.

  ## Examples

      iex> list_teams()
      [%Team{}, ...]

  """
  def list_teams do
    Repo.all(Team) |> Repo.preload(:manager) |> Repo.preload(:users)
  end

  @doc """
  Gets a single team.

  Raises `Ecto.NoResultsError` if the Team does not exist.

  ## Examples

      iex> get_team!(123)
      %Team{}

      iex> get_team!(456)
      ** (Ecto.NoResultsError)

  """
  def get_team!(id), do: Repo.get!(Team, id) |> Repo.preload(:manager) |> Repo.preload(:users)

  @doc """
  Gets a manager's teams.

  Raises `Ecto.NoResultsError` if the Team does not exist.

  ## Examples

      iex> get_teams_by_manager!(123)
      %Team{}

      iex> get_teams_by_manager!(456)
      ** (Ecto.NoResultsError)

  """
  def get_teams_by_manager(id) do
    query = from t in Team,
      where: t.manager_id == ^id,
      preload: [:manager, :users]

    Repo.all(query)

  end

  @doc """
  Creates a team.

  ## Examples

      iex> create_team(%{field: value})
      {:ok, %Team{}}

      iex> create_team(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_team(attrs \\ %{}, manager) do
    %Team{manager: manager}
    |> Ecto.Changeset.change()
    |> Team.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a team.

  ## Examples

  iex> update_team(team, %{field: new_value})
  {:ok, %Team{}}

  iex> update_team(team, %{field: bad_value})
  {:error, %Ecto.Changeset{}}

  """
  def update_team(%Team{} = team, attrs) do
    team
    |> Repo.preload(:manager)
    |> Repo.preload(:users)
    |> Team.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Team.

  ## Examples

      iex> delete_team(team)
      {:ok, %Team{}}

      iex> delete_team(team)
      {:error, %Ecto.Changeset{}}

  """
  def delete_team(%Team{} = team) do
    Repo.delete(team)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking team changes.

  ## Examples

      iex> change_team(team)
      %Ecto.Changeset{source: %Team{}}

  """
  def change_team(%Team{} = team) do
    Team.changeset(team, %{})
  end
  
  def get_team_members(id) do
    query = from t in Team,
      where: t.id == ^id,
      preload: [:users]
    Repo.all(query)
  end

end
