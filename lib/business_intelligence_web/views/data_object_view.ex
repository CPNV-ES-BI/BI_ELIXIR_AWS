defmodule BusinessIntelligenceWeb.DataObjectView do
  use BusinessIntelligenceWeb, :view
  alias BusinessIntelligenceWeb.DataObjectView

  def render("index.json", %{game_types: game_types}) do
    %{data: render_many(game_types, DataObjectView, "data_object.json")}
  end

  def render("create.json", _) do
    %{status: "Created"}
  end

  def render("show.json", %{data_object: data_object}) do
    %{data: render_one(data_object, DataObjectView, "data_object.json")}
  end

  def render("publish.json", %{data_object: %{name: name, url: url}}) do
    %{data: %{name: name, url: url}}
  end

  def render("delete.json", %{data_objects: data_objects}) do
    %{data: %{deleted: data_objects}}
  end

  def render("data_object.json", %{data_object: %{name: name, content: content}}) do
    %{
      name: name,
      content: content
    }
  end
end
