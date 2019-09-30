use Mix.Config

# Configure your database
config :miniprojet, Gotham.Repo,
  username: "postgres",
  password: "postgres",
  database: "miniprojet_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :miniprojet, GothamWeb.Endpoint,
  http: [port: 4002],
  server: false

# Config argon2 for test purpose, reduce the amount of computation and memory usage to not slow down the test suite
config :argon2_elixir, t_cost: 1, m_cost: 8

# Print only warnings and errors during test
config :logger, level: :warn
