defmodule Gotham.Repo do
  use Ecto.Repo,
    otp_app: :miniprojet,
    adapter: Ecto.Adapters.Postgres

  def init(config) do
    config = config
      |> Keyword.put(:username, System.get_env("DB_USERNAME") || "postgres")
      |> Keyword.put(:password, System.get_env("DB_PASSWORD") || "7pGd94CGu6n3B9BH")
      |> Keyword.put(:database, System.get_env("DB_NAME") || "gotham")
      |> Keyword.put(:hostname, System.get_env("DB_HOST") || "gotham-254312:europe-west1:gotham-db-instance")
      |> Keyword.put(:port, System.get_env("PORT") || "4000" |> String.to_integer)
    {:ok, config}
  end
end
