defmodule Gotham.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  import EctoEnum

  defenum RolesEnum, :role, [:employee, :manager, :admin]

  schema "users" do
    field :email, :string
    field :username, :string
    field :role, RolesEnum
    has_one :clock, Gotham.Times.Clock
    has_many :workingtimes, Gotham.Times.Workingtime
    many_to_many :teams, Gotham.Accounts.Team, join_through: "users_teams"

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :email])
    # |> cast_assoc(:clock, attrs.clock)
    # |> cast_assoc(:workingtimes, attrs.workingtimes)
    # |> cast_assoc(:teams, attrs.teams)
    |> validate_required([:username, :email])
    |> unique_constraint(:email)
    |> validate_format(:email, ~r/@/)
  end

end
