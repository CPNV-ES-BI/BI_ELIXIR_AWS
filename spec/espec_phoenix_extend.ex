defmodule ESpec.Phoenix.Extend do
  def model do
    quote do
      alias BusinessIntelligence.Repo
    end
  end

  def controller do
    quote do
      alias BusinessIntelligence
      import BusinessIntelligenceWeb.Router.Helpers

      @endpoint BusinessIntelligenceWeb.Endpoint
    end
  end

  def view do
    quote do
      import BusinessIntelligenceWeb.Router.Helpers
    end
  end

  def channel do
    quote do
      alias BusinessIntelligence.Repo

      @endpoint BusinessIntelligenceWeb.Endpoint
    end
  end

  def live_view do
    quote do
      alias BusinessIntelligence
      import BusinessIntelligenceWeb.Router.Helpers

      @endpoint BusinessIntelligenceWeb.Endpoint
    end
  end

  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
