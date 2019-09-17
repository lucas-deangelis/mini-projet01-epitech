defmodule Gotham.Accounts.Team do
  use Ecto.Schema
  import Ecto.Changeset

  schema "teams" do
    field :name, :string
    field :manager_id, :id
    many_to_many :users, Gotham.Accounts.User, join_through: "users_teams"


    timestamps()
  end

  @doc false
  def changeset(team, attrs) do
    team
    |> cast(attrs, [:name, :manager_id])
    |> validate_required([:name, :manager_id])
  end
end
