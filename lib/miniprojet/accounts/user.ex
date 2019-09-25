defmodule Gotham.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  import EctoEnum

  defenum RolesEnum, :role, [:employee, :manager, :admin]

  schema "users" do
    # Base fields
    field :email, :string
    field :username, :string
    field :role, RolesEnum
    field :password_hash, :string
    # Virtual fields:
    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true
    # Assocs
    has_one :clock, Gotham.Times.Clock
    has_many :workingtimes, Gotham.Times.Workingtime
    many_to_many :teams, Gotham.Accounts.Team, join_through: "users_teams"


    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :email, :role, :password, :password_confirmation])
    |> cast_assoc(:clock, with: &Gotham.Times.Clock.changeset/2)
    |> cast_assoc(:workingtimes, with: &Gotham.Times.Workingtime.changeset/2)
    |> cast_assoc(:teams, with: &Gotham.Accounts.Team.changeset/2)
    |> validate_required([:username, :email, :role, :password, :password_confirmation])
    |> validate_length(:password, min: 6) # Check that password length is >= 6
    |> validate_confirmation(:password) # Check that password === password_confirmation
    |> unique_constraint(:email)
    |> validate_format(:email, ~r/@/)
    |> put_password_hash # Add put_password_hash to changeset pipeline
  end

  def changeset_update(user, attrs) do
    user
    |> cast(attrs, [:username, :email, :role])
    |> cast_assoc(:clock, with: &Gotham.Times.Clock.changeset/2)
    |> cast_assoc(:workingtimes, with: &Gotham.Times.Workingtime.changeset/2)
    |> cast_assoc(:teams, with: &Gotham.Accounts.Team.changeset/2)
    |> validate_required([:username, :email, :role])
    |> unique_constraint(:email)
    |> validate_format(:email, ~r/@/)
  end

  # Hash the password
  defp put_password_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: password}}
        ->
          put_change(changeset, :password_hash, Argon2.hash_pwd_salt(password))
      _ ->
          changeset
    end
  end

end
