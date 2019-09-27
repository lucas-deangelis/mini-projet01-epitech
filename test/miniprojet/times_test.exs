defmodule Gotham.TimesTest do
  use Gotham.DataCase

  alias Gotham.Times
  alias Gotham.Accounts
  alias Gotham.Repo

  describe "clocks" do
    alias Gotham.Times.Clock

    @valid_attrs %{status: true, time: ~N[2010-04-17 14:00:00]}
    @update_attrs %{status: false, time: ~N[2011-05-18 15:01:01]}
    @invalid_attrs %{status: nil, time: nil}
    @valid_attrs_user %{email: "test@yopmail.com", username: "some username", role: "manager", password: "aaaaaa", password_confirmation: "aaaaaa"}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs_user)
        |> Accounts.create_user()

      user
    end

    def clock_fixture(attrs \\ %{}, user) do
      {:ok, clock} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Times.create_clock(user)

      clock
    end

    test "list_clocks/0 returns all clocks" do
      user = user_fixture()
      clock = clock_fixture(user)
      clocks = Repo.all(Clock)
      [head] = clocks

      assert length(clocks) == 1
      assert head.status == clock.status
      assert head.id == clock.id
    end

    test "get_clock!/1 returns the clock with given id" do
      user = user_fixture()
      clock = clock_fixture(user)
      clock2 = Times.get_clock!(clock.id)
      assert clock2.id == clock.id
      assert clock2.status == clock.status
      assert clock2.time == clock.time
    end

    test "create_clock/1 with valid data creates a clock" do
      user = user_fixture()
      assert {:ok, %Clock{} = clock} = Times.create_clock(@valid_attrs, user)
      assert clock.status == true
      assert clock.time == ~N[2010-04-17 14:00:00]
    end

    test "create_clock/1 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Times.create_clock(@invalid_attrs, user)
    end

    test "update_clock/2 with valid data updates the clock" do
      user = user_fixture()
      clock = clock_fixture(user)
      assert {:ok, %Clock{} = clock} = Times.update_clock(clock, @update_attrs)
      assert clock.status == false
      assert clock.time == ~N[2011-05-18 15:01:01]
    end

    test "update_clock/2 with invalid data returns error changeset" do
      user = user_fixture()
      clock = clock_fixture(user)
      assert {:error, %Ecto.Changeset{}} = Times.update_clock(clock, @invalid_attrs)
    end

    test "delete_clock/1 deletes the clock" do
      user = user_fixture()
      clock = clock_fixture(user)
      assert {:ok, %Clock{}} = Times.delete_clock(clock)
      assert_raise Ecto.NoResultsError, fn -> Times.get_clock!(clock.id) end
    end

    test "change_clock/1 returns a clock changeset" do
      user = user_fixture()
      clock = clock_fixture(user)
      assert %Ecto.Changeset{} = Times.change_clock(clock)
    end
  end

  describe "workingtimes" do
    alias Gotham.Times.Workingtime

    @valid_attrs %{end: ~N[2010-04-17 14:00:00], start: ~N[2010-04-17 14:00:00]}
    @update_attrs %{end: ~N[2011-05-18 15:01:01], start: ~N[2011-05-18 15:01:01]}
    @invalid_attrs %{end: nil, start: nil}

    def workingtime_fixture(attrs \\ %{}, user) do
      {:ok, workingtime} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Times.create_workingtime(user)

      workingtime
    end

    test "list_workingtimes/0 returns all workingtimes" do
      user = user_fixture()
      workingtime = workingtime_fixture(user)
      assert Times.list_workingtimes() == [workingtime]
    end

    test "get_workingtime!/1 returns the workingtime with given id" do
      user = user_fixture()
      workingtime = workingtime_fixture(user)
      assert Times.get_workingtime!(workingtime.id) == workingtime
    end

    test "create_workingtime/1 with valid data creates a workingtime" do
      user = user_fixture()
      assert {:ok, %Workingtime{} = workingtime} = Times.create_workingtime(@valid_attrs, user)
      assert workingtime.end == ~N[2010-04-17 14:00:00]
      assert workingtime.start == ~N[2010-04-17 14:00:00]
    end

    test "create_workingtime/1 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Times.create_workingtime(@invalid_attrs, user)
    end

    test "update_workingtime/2 with valid data updates the workingtime" do
      user = user_fixture()
      workingtime = workingtime_fixture(user)
      assert {:ok, %Workingtime{} = workingtime} = Times.update_workingtime(workingtime, @update_attrs)
      assert workingtime.end == ~N[2011-05-18 15:01:01]
      assert workingtime.start == ~N[2011-05-18 15:01:01]
    end

    test "update_workingtime/2 with invalid data returns error changeset" do
      user = user_fixture()
      workingtime = workingtime_fixture(user)
      assert {:error, %Ecto.Changeset{}} = Times.update_workingtime(workingtime, @invalid_attrs)
      assert workingtime == Times.get_workingtime!(workingtime.id)
    end

    test "delete_workingtime/1 deletes the workingtime" do
      user = user_fixture()
      workingtime = workingtime_fixture(user)
      assert {:ok, %Workingtime{}} = Times.delete_workingtime(workingtime)
      assert_raise Ecto.NoResultsError, fn -> Times.get_workingtime!(workingtime.id) end
    end

    test "change_workingtime/1 returns a workingtime changeset" do
      user = user_fixture()
      workingtime = workingtime_fixture(user)
      assert %Ecto.Changeset{} = Times.change_workingtime(workingtime)
    end
  end
end
