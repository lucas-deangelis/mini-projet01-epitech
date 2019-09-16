defmodule Gotham.Repo.Migrations.UsersAddRoleColumn do
  use Ecto.Migration

  def change do
	RolesEnum.create_type
	alter table("users") do
		add :role, RolesEnum.type()
	end
  end
end
