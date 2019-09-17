defmodule Gotham.Repo.Migrations.AddUsersTeamsTable do
  use Ecto.Migration

  def change do
    create table(:users_teams, primary_key: false) do
      add :user_id, references(:users)
      add :team_id, references(:teams)
    end

    create index(:users_teams, [:user_id, :team_id])
  end
end
