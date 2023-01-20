defmodule BusinessIntelligenceWeb.Router do
  use BusinessIntelligenceWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", BusinessIntelligenceWeb do
    pipe_through :api
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through [:fetch_session, :protect_from_forgery]

      live_dashboard "/dashboard", metrics: BusinessIntelligenceWeb.Telemetry
    end
  end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end

  scope "/", BusinessIntelligenceWeb do
    pipe_through [:api]

    resources "/data-objects", DataObjectController,
      only: [:create, :show, :delete],
      param: "name"

    patch "/data-objects/:name/publish", DataObjectController, :publish
  end
end
