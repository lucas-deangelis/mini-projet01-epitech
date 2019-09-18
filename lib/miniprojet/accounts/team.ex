defmodule Gotham.Accounts.Team do
  use Ecto.Schema
  import Ecto.Changeset

  schema "teams" do
    field :name, :string
    belongs_to :manager, Gotham.Accounts.User
    many_to_many :users, Gotham.Accounts.User, join_through: "users_teams"

    timestamps()
  end

  @doc false
  def changeset(team, attrs) do
    team
    |> cast(attrs, [:name])
    |> cast_assoc(:users, with: &Gotham.Accounts.User.changeset/2)
    |> cast_assoc(:manager, with: &Gotham.Accounts.User.changeset/2)
    |> validate_required([:name, :manager])
  end
end
