defmodule BusinessIntelligence.Repo do
  use Ecto.Repo,
    otp_app: :bi_aws,
    adapter: Ecto.Adapters.SQLite3
end
