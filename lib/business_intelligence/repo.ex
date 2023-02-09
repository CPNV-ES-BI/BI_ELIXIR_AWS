defmodule BusinessIntelligence.Repo do
  use Ecto.Repo,
    otp_app: :business_intelligence,
    adapter: Ecto.Adapters.SQLite3
end
