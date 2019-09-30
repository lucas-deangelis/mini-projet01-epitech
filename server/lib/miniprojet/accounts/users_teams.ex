defmodule Gotham.Accounts.UserTeam do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  schema "users_teams" do
    belongs_to :user, Gotham.Accounts.User
    belongs_to :team, Gotham.Accounts.Team
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:user_id, :team_id])
    |> validate_required([:user_id, :team_id])
    # Maybe do some counter caching here!
  end
end
