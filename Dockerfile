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

ARG BUILDER_IMAGE="hexpm/elixir:${ELIXIR_VERSION}-erlang-${OTP_VERSION}-debian-${DEBIAN_VERSION}"

FROM ${BUILDER_IMAGE} as builder

ARG UNAME=bi
ARG UID=1000
ARG GID=1000
RUN groupadd -g $GID -o $UNAME
RUN useradd -m -u $UID -g $GID -o -s /bin/bash $UNAME

# install build dependencies
RUN apt-get update -y && apt-get install -y build-essential git curl vim bash watchman procps iproute2 lsof\
    && apt-get clean && rm -f /var/lib/apt/lists/*_*

USER $UNAME
# install hex + rebar
RUN mix local.hex --force && \
    mix local.rebar --force

# prepare build dir
USER root
ENV APP_HOME /app
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

RUN chown -R $UNAME:$UNAME $APP_HOME

COPY ./entrypoint.sh .
RUN sed -i 's/\r$//' ./entrypoint.sh \
    && chmod +x ./entrypoint.sh

ENTRYPOINT ["./entrypoint.sh"]

USER $UNAME

ENV MIX_ENV="dev"

# Elixir remote session port
EXPOSE 4369
EXPOSE 4000
