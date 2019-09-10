defmodule Gotham.Users do
  use Ecto.Schema
  import Ecto.Changeset

  schema "user" do
    field :email, :string
    field :username, :string

    timestamps()
  end

  @doc false
  def changeset(users, attrs) do
    users
    |> cast(attrs, [:username, :email])
    |> validate_required([:username, :email])
  end
end
