defmodule Gotham.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:user) do
      add :username, :string
      add :email, :string

      timestamps()
    end

  end
end
