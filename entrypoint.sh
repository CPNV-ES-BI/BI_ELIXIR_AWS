#!/bin/bash

set -e

# Ensure the app's dependencies are installed
mix deps.get

# Compile dependencies
mix deps.compile

# Create database and run migrations
mix ecto.create
mix ecto.migrate

# Launch Elixir's remote session
elixir --name docker@172.40.0.2 --cookie business_intelligence -S mix phx.server
