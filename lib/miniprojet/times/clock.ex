defmodule Gotham.Times.Clock do
  use Ecto.Schema
  import Ecto.Changeset

  schema "clocks" do
    field :status, :boolean, default: false
    field :time, :naive_datetime
    belongs_to :user, Gotham.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(clock, attrs) do
    clock
    |> cast(attrs, [:time, :status])
    |> put_assoc(:user, attrs.user)
    |> validate_required([:time, :status, :user])
  end
end
