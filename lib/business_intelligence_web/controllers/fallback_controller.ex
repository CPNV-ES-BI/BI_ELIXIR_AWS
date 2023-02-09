defmodule BusinessIntelligenceWeb.FallbackController do
  require Logger

  @moduledoc """
  Translates controller action results into valid `Plug.Conn` responses.

  See `Phoenix.Controller.action_fallback/1` for more details.
  """
  use BusinessIntelligenceWeb, :controller

  # This clause handles errors returned by Ecto's insert/update/delete.
  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(BusinessIntelligenceWeb.ChangesetView)
    |> render("error.json", changeset: changeset)
  end

  def call(conn, {:error, :bad_request}) do
    conn
    |> put_status(:bad_request)
    |> put_view(BusinessIntelligenceWeb.ErrorView)
    |> render(:"400")
  end

  # This clause is an example of how to handle resources that cannot be found.
  def call(conn, {:error, :object_not_found}) do
    conn
    |> put_status(:not_found)
    |> put_view(BusinessIntelligenceWeb.ErrorView)
    |> render(:"404")
  end

  def call(conn, {:error, :already_exists}) do
    conn
    |> put_status(:conflict)
    |> put_view(BusinessIntelligenceWeb.ErrorView)
    |> render(:"409")
  end

  def call(conn, {:error, :unexpected_response}) do
    conn
    |> put_status(:internal_server_error)
    |> put_view(BusinessIntelligenceWeb.ErrorView)
    |> render(:"500")
  end

  def call(_conn, params) do
    Logger.debug("Got params from fallback ==> #{inspect(params)}")
  end
end
