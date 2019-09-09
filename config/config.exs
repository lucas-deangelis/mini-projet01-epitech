# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :miniprojet,
  namespace: Gotham,
  ecto_repos: [Gotham.Repo]

# Configures the endpoint
config :miniprojet, GothamWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "8PL3ksx+/ifrP+Aq9Ndb64IeAvAFYZ+i60FF33p4H8UpeJpo624EUtamFoj3TNVg",
  render_errors: [view: GothamWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: Gotham.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
