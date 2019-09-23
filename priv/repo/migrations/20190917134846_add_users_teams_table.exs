defmodule Gotham.Repo.Migrations.AddUsersTeamsTable do
  use Ecto.Migration

  def change do
    create table(:users_teams, primary_key: false) do
      add :user_id, references(:users, on_delete: :delete_all)
      add :team_id, references(:teams, on_delete: :delete_all)
    end

    # create unique_index(:users_teams, [:user_id, :team_id])
  end
end
