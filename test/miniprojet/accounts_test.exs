defmodule Gotham.AccountsTest do
  use Gotham.DataCase

  alias Gotham.Accounts
  alias Gotham.Repo

  describe "users" do
    alias Gotham.Accounts.User

    @valid_attrs %{email: "test@yopmail.com", username: "some username", role: "manager", password: "aaaaaa", password_confirmation: "aaaaaa"}
    @update_attrs %{email: "testupdated@yopmail.com", username: "some updated username", role: "employee"}
    @invalid_attrs %{email: nil, username: nil, role: nil, password: nil, password_confirmation: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_user()

      user
    end

    # test "list_users/0 returns all users" do
    #   user = user_fixture()
    #   assert Accounts.list_users() == [user]
    # end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      user2 = Accounts.get_user!(user.id)
      assert user2.id == user.id
      assert user2.email == user.email
      assert user2.username == user.username
      assert user2.role == user.role
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Accounts.create_user(@valid_attrs)
      assert user.email == "test@yopmail.com"
      assert user.username == "some username"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, %User{} = user} = Accounts.update_user(user, @update_attrs)
      assert user.email == "testupdated@yopmail.com"
      assert user.username == "some updated username"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_attrs)
      assert user != Accounts.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Accounts.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Accounts.change_user(user)
    end
  end

  describe "teams" do
    alias Gotham.Accounts.Team

    @valid_attrs %{name: "some name", users: []}
    @update_attrs %{name: "some updated name", users: []}
    @invalid_attrs %{name: nil}

    def team_fixture(attrs \\ %{}, manager) do
      {:ok, team} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_team(manager)

      team
    end

    test "list_teams/0 returns all teams" do
      manager = user_fixture()
      team = team_fixture(manager)

      teams = Repo.all(Team) |> Repo.preload(:manager) |> Repo.preload(:users)
      [head] = teams

      assert length(teams) == 1
      assert head.name == team.name
      assert head.id == team.id
    end

    test "get_team!/1 returns the team with given id" do
      manager = user_fixture()
      team = team_fixture(manager)
      team2 = Accounts.get_team!(team.id)
      assert team2.id == team.id
      assert team2.name == team.name
      assert team2.manager_id == team.manager_id
    end

    test "create_team/1 with valid data creates a team" do
      manager = user_fixture()
      assert {:ok, %Team{} = team} = Accounts.create_team(@valid_attrs, manager)
      assert team.name == "some name"
    end

    test "create_team/1 with invalid data returns error changeset" do
      manager = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.create_team(@invalid_attrs, manager)
    end

    test "update_team/2 with valid data updates the team" do
      manager = user_fixture()
      team = team_fixture(manager)
      assert {:ok, %Team{} = team} = Accounts.update_team(team, @update_attrs)
      assert team.name == "some updated name"
    end

    test "update_team/2 with invalid data returns error changeset" do
      manager = user_fixture()
      team = team_fixture(manager)
      assert {:error, %Ecto.Changeset{}} = Accounts.update_team(team, @invalid_attrs)
    end

    test "delete_team/1 deletes the team" do
      manager = user_fixture()
      team = team_fixture(manager)
      assert {:ok, %Team{}} = Accounts.delete_team(team)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_team!(team.id) end
    end

    test "change_team/1 returns a team changeset" do
      manager = user_fixture()
      team = team_fixture(manager)
      assert %Ecto.Changeset{} = Accounts.change_team(team)
    end
  end
end
