defmodule Gotham.Repo do
  use Ecto.Repo,
    otp_app: :miniprojet,
    adapter: Ecto.Adapters.Postgres
end
