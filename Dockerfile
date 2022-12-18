# Find eligible builder and runner images on Docker Hub. We use Ubuntu/Debian instead of
# Alpine to avoid DNS resolution issues in production.
#
# https://hub.docker.com/r/hexpm/elixir/tags?page=1&name=ubuntu
# https://hub.docker.com/_/ubuntu?tab=tags
#
#
# This file is based on these images:
#
#   - https://hub.docker.com/r/hexpm/elixir/tags - for the build image
#   - https://hub.docker.com/_/debian?tab=tags&page=1&name=bullseye-20221004-slim - for the release image
#   - https://pkgs.org/ - resource for finding needed packages
#   - Ex: hexpm/elixir:1.14.2-erlang-25.1.2-debian-bullseye-20221004-slim
#
ARG ELIXIR_VERSION=1.14.2
ARG OTP_VERSION=25.1.2
ARG DEBIAN_VERSION=bullseye-20221004-slim
ARG ALPINE_VERSION=alpine-3.16.2

ARG BUILDER_IMAGE="hexpm/elixir:${ELIXIR_VERSION}-erlang-${OTP_VERSION}-debian-${DEBIAN_VERSION}"

FROM ${BUILDER_IMAGE} as builder

# install build dependencies
RUN apt-get update -y && apt-get install -y build-essential git curl vim bash watchman procps iproute2 lsof\
    && apt-get clean && rm -f /var/lib/apt/lists/*_*

# install hex + rebar
RUN mix local.hex --force && \
    mix local.rebar --force

# prepare build dir
ENV APP_HOME /app
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

ENV MIX_ENV="dev"

EXPOSE 4000
EXPOSE 4369