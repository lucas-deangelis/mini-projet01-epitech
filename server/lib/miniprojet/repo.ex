defmodule Gotham.Repo do
  use Ecto.Repo,
    otp_app: :miniprojet,
    adapter: Ecto.Adapters.Postgres

  def init(config) do
    config = config
      |> Keyword.put(:username, System.get_env("DB_USERNAME"))
      |> Keyword.put(:password, System.get_env("DB_PASSWORD"))
      |> Keyword.put(:database, System.get_env("DB_NAME"))
      |> Keyword.put(:hostname, System.get_env("DB_HOSTNAME"))
      |> Keyword.put(:port, System.get_env("DB_PORT") |> String.to_integer)
    {:ok, config}
  end
end
