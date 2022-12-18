# require phoenix_helper.exs
Code.require_file("#{__DIR__}/phoenix_helper.exs")

ESpec.configure(fn config ->
  config.before(fn _tags ->
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(BusinessIntelligence.Repo)
  end)

  config.finally(fn _shared ->
    Ecto.Adapters.SQL.Sandbox.checkin(BusinessIntelligence.Repo, [])
  end)
end)
