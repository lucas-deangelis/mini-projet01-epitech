defmodule Gotham.Repo.Migrations.CreateTeams do
  use Ecto.Migration

  def change do
    create table(:teams) do
      add :name, :string
      add :manager, references(:users, on_delete: :nothing)
      add :users, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:teams, [:manager])
    create index(:teams, [:users])
  end
end
