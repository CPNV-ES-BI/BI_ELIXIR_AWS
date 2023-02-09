defmodule BusinessIntelligenceWeb.ErrorView do
  use BusinessIntelligenceWeb, :view
  require Logger

  # If you want to customize a particular status code
  # for a certain format, you may uncomment below.
  # def render("500.json", _assigns) do
  #   %{errors: %{detail: "Internal Server Error"}}
  # end
  def render("400.json", %{reason: reason}) do
    %{error: %{code: 400, message: reason}}
  end

  def render("401.json", %{reason: reason}) do
    %{error: %{code: 401, message: reason}}
  end

  def render("403.json", _assigns) do
    %{error: %{code: 403, message: "Forbidden"}}
  end

  def render("404.json", _assigns) do
    %{error: %{code: 404, message: "Page not found"}}
  end

  def render("409.json", _assigns) do
    %{error: %{code: 409, message: "Conflict"}}
  end

  def render("422.json", _assigns) do
    %{error: %{code: 422, message: "Unprocessable entity"}}
  end

  def render("500.json", _assigns) do
    %{error: %{code: 500, message: "Internal Server Error"}}
  end

  # # By default, Phoenix returns the status message from
  # # the template name. For example, "404.json" becomes
  # # "Not Found".
  def template_not_found(template, _assigns) do
    Logger.debug(inspect(template))
    %{errors: %{detail: Phoenix.Controller.status_message_from_template(template)}}
  end
end
