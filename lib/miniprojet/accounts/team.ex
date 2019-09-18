defmodule Gotham.Accounts.Team do
  use Ecto.Schema
  import Ecto.Changeset

  schema "teams" do
    field :name, :string
    belongs_to :manager, Gotham.Accounts.User, on_replace: :update
    many_to_many :users, Gotham.Accounts.User, join_through: "users_teams"


    timestamps()
  end

  @doc false
  def changeset(team, attrs) do
    team
    |> cast(attrs, [:name, :manager_id])
    |> put_assoc(:users, attrs.users)
    |> put_assoc(:manager, attrs.manager)
    |> validate_required([:name, :manager_id])
  end
end
