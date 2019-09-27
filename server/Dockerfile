# Use an official Elixir runtime as a parent image
FROM elixir:1.9.1

RUN apt-get update && \
  apt-get install -y postgresql-client

# Create app directory and copy the Elixir projects into it
RUN mkdir /app
COPY . /app
WORKDIR /app

# Install hex package manager
RUN mix local.hex --force

# Get dependancies
RUN mix deps.get

# Getting rebar3
RUN mix local.rebar --force

# Compile the project
RUN mix do compile

RUN mix ecto.setup

# EXPOSE 4000

# CMD ["chmod", "+x", "/app/entrypoint.sh"]

# ENTRYPOINT ["/app/entrypoint.sh"]
