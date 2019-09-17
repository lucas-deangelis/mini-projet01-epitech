defmodule Gotham.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :username, :string
    has_one :clocks, Gotham.Times.Clock
    has_many :workingtimes, Gotham.Times.Workingtime
    has_many :teams, Gotham.Accounts.Team

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :email])
    |> validate_required([:username, :email])
    |> unique_constraint(:email)
    |> validate_format(:email, ~r/@/)
  end
end
