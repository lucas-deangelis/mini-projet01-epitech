# The version of Alpine to use for the final image
# This should match the version of Alpine that the `elixir:1.7.2-alpine` image uses
ARG ALPINE_VERSION=3.8

FROM elixir:1.9.1 AS builder

# The following are build arguments used to change variable parts of the image.
# The name of your application/release (required)
ARG APP_NAME=miniprojet
# The version of the application we are building (required)
ARG APP_VSN=0.1.0
# The environment to build with
ARG MIX_ENV=prod

ENV APP_NAME=${APP_NAME} APP_VSN=${APP_VSN} MIX_ENV=${MIX_ENV} REPLACE_OS_VARS=true

# By convention, /opt is typically used for applications
WORKDIR /opt/app

# This step installs all the build tools we'll need
RUN apt-get update && \
  mix local.rebar --force && \
  mix local.hex --force

# This copies our app source code into the build container
COPY . .

# Get dependencies and compile the project
RUN mix clean
RUN mix do deps.get --only prod
RUN mix compile --prod

# Create a new release fpr the production
RUN mix release ${APP_NAME} \
    && mv _build/${MIX_ENV}/rel/${APP_NAME} /opt/release \
    && mv /opt/release/bin/${APP_NAME} /opt/release/bin/start_server

# # From this line onwards, we're in a new image, which will be the image used in production
FROM alpine:3.9

ARG GCLOUD_PROJECT_ID=gotham-254312
ARG PORT=4000

# Install build tools and cloud_sql_proxy
RUN apk update \
    && apk --no-cache --update add bash ca-certificates openssl-dev \
    && mkdir -p /usr/local/bin \
    && wget https://dl.google.com/cloudsql/cloud_sql_proxy.linux.amd64 \
        -O /usr/local/bin/cloud_sql_proxy \
    && chmod +x /usr/local/bin/cloud_sql_proxy \
    && mkdir -p /tmp/cloudsql

ENV PORT=4000 GCLOUD_PROJECT_ID=${GCLOUD_PROJECT_ID} REPLACE_OS_VARS=true

EXPOSE ${PORT}

WORKDIR /opt/app

COPY --from=0 /opt/release .

# Execute the production release and the cloud sql proxy
CMD (/usr/local/bin/cloud_sql_proxy \
      -projects=${GCLOUD_PROJECT_ID} -dir=/tmp/cloudsql &); \
      exec /opt/app/bin/start_server start eval "Gotham.Release.migrate"