defmodule Gotham.Times do
  @moduledoc """
  The Times context.
  """

  import Ecto.Query, warn: false
  alias Gotham.Repo
  alias Gotham.Times.Clock
  alias Gotham.Times.Workingtime
  alias Gotham.Accounts.User

  @doc """
  Returns the list of clocks.

  ## Examples

      iex> list_clocks()
      [%Clock{}, ...]

  """
  def list_clocks do
    Repo.all(Clock)
  end

  @doc """
  Gets a single clock.

  Raises `Ecto.NoResultsError` if the Clock does not exist.

  ## Examples

      iex> get_clock!(123)
      %Clock{}

      iex> get_clock!(456)
      ** (Ecto.NoResultsError)

  """
  def get_clock!(id), do: Repo.get!(Clock, id)

  @doc """
  Gets a single clock.

  ## Examples

      iex> get_clock!(123)
      %Clock{}

      iex> get_clock!(456)
      ** (Ecto.NoResultsError)

  """
  def get_clock(id), do: Repo.get(Clock, id)

  @doc """
  Gets a single clock by user id.

  Raises `Ecto.NoResultsError` if the Clock does not exist.

  ## Examples

      iex> get_clock!(123)
      %Clock{}

      iex> get_clock!(456)
      ** (Ecto.NoResultsError)

  """
  def get_clock_by_user(id) do

    query = from c in Clock,
      join: u in User,
      on: c.user_id == u.id,
      where: u.id == ^id

    Repo.one(query)
  end

  @doc """
  Creates a clock.

  ## Examples

      iex> create_clock(%{field: value})
      {:ok, %Clock{}}

      iex> create_clock(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_clock(attrs \\ %{}, user) do
    %Clock{user: user}
    |> Ecto.Changeset.change()
    |> Clock.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a clock.

  ## Examples

      iex> update_clock(clock, %{field: new_value})
      {:ok, %Clock{}}

      iex> update_clock(clock, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_clock(%Clock{} = clock, attrs) do
    clock
    |> Repo.preload(:user)
    |> Clock.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Clock.

  ## Examples

      iex> delete_clock(clock)
      {:ok, %Clock{}}

      iex> delete_clock(clock)
      {:error, %Ecto.Changeset{}}

  """
  def delete_clock(%Clock{} = clock) do
    Repo.delete(clock)
  end

  @doc """
  Deletes User's clocks.

  ## Examples

      iex> delete_clock_all_by_user(id)
      {:ok, ""}

      iex> delete_clock_all_by_user(id)
      {:error, %Ecto.Changeset{}}

  """
  def delete_clock_all_by_user(id) do
    query = from c in Clock,
      join: u in User,
      on: c.user_id == u.id,
      where: u.id == ^id

    Ecto.Multi.new()
    |> Ecto.Multi.delete_all(:delete_all, query)
    |> Repo.transaction()
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking clock changes.

  ## Examples

      iex> change_clock(clock)
      %Ecto.Changeset{source: %Clock{}}

  """
  def change_clock(%Clock{} = clock) do
    Clock.changeset(clock, %{})
  end

  alias Gotham.Times.Workingtime

  @doc """
  Returns the list of workingtimes.

  ## Examples

      iex> list_workingtimes()
      [%Workingtime{}, ...]

  """
  def list_workingtimes do
    Repo.all(Workingtime)
  end

  @doc """
  Gets a single workingtime.

  Raises `Ecto.NoResultsError` if the Workingtime does not exist.

  ## Examples

      iex> get_workingtime!(123)
      %Workingtime{}

      iex> get_workingtime!(456)
      ** (Ecto.NoResultsError)

  """
  def get_workingtime!(workingtimeId) do
    Repo.get(Workingtime, workingtimeId)
  end

  def get_workingtimeUser!(workingtimeId, userId) do
    query = from w in Workingtime,
      where: w.id == ^workingtimeId,
      where: w.user_id == ^userId

    Repo.one(query)
  end

  @doc """
  Gets a single workingtime by its attributes start and end.

  Raises `Ecto.NoResultsError` if the Workingtime does not exist.

  ## Examples

      iex> get_workingtime!(123)
      %Workingtime{}

      iex> get_workingtime!(456)
      ** (Ecto.NoResultsError)

  """
  def get_workingtime_by_attr(id, starttime, endtime) do


    query = from w in Workingtime,
      join: u in User,
      on: w.user_id == u.id,
      where: u.id == ^id

    # filter working time by starttime if not null
    if !is_nil(starttime) do
      query = from [w, u] in query,
      where: w.start >= ^starttime
    end
    #filter working time by endtime if not null
    if !is_nil(endtime) do
      query = from [w, u] in query,
      where: w.end <= ^endtime
    end

    Repo.all(query)
  end

  @doc """
  Creates a workingtime.

  ## Examples

      iex> create_workingtime(%{field: value})
      {:ok, %Workingtime{}}

      iex> create_workingtime(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_workingtime(attrs \\ %{}, user) do
    %Workingtime{user: user}
    |> Ecto.Changeset.change()
    |> Workingtime.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a workingtime.

  ## Examples

      iex> update_workingtime(workingtime, %{field: new_value})
      {:ok, %Workingtime{}}

      iex> update_workingtime(workingtime, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_workingtime(%Workingtime{} = workingtime, attrs \\ %{}) do
    workingtime
    |> Workingtime.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Workingtime.

  ## Examples

      iex> delete_workingtime(workingtime)
      {:ok, %Workingtime{}}

      iex> delete_workingtime(workingtime)
      {:error, %Ecto.Changeset{}}

  """
  def delete_workingtime(%Workingtime{} = workingtime) do
    Repo.delete(workingtime)
  end

  @doc """
  Deletes User's Workingtime.

  ## Examples

      iex> delete_workingtime_all_by_user(workingtime)
      {:ok, %Workingtime{}}

      iex> delete_workingtime_all_by_user(workingtime)
      {:error, %Ecto.Changeset{}}

  """
  def delete_workingtime_all_by_user(id) do
    query = from w in Workingtime,
      join: u in User,
      on: w.user_id == u.id,
      where: u.id == ^id

    Ecto.Multi.new()
    |> Ecto.Multi.delete_all(:delete_all, query)
    |> Repo.transaction()
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking workingtime changes.

  ## Examples

      iex> change_workingtime(workingtime)
      %Ecto.Changeset{source: %Workingtime{}}

  """
  def change_workingtime(%Workingtime{} = workingtime) do
    Workingtime.changeset(workingtime, %{})
  end
end
