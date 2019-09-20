defmodule Gotham.Repo do
  use Ecto.Repo,
    otp_app: :miniprojet,
    adapter: Ecto.Adapters.Postgres

<<<<<<< HEAD
=======
  def init(config) do
    config = config
      |> Keyword.put(:username, System.get_env("PGUSER"))
      |> Keyword.put(:password, System.get_env("PGPASSWORD"))
      |> Keyword.put(:database, System.get_env("PGDATABASE"))
      |> Keyword.put(:hostname, System.get_env("PGHOST"))
      |> Keyword.put(:port, System.get_env("PGPORT") |> String.to_integer)
    {:ok, config}
  end
>>>>>>> dce9bc3b1cddc28f00fb49190b8316b52bc40000
end
