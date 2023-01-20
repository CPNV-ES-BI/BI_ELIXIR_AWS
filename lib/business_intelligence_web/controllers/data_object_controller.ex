defmodule BusinessIntelligenceWeb.DataObjectController do
  use BusinessIntelligenceWeb, :controller
  alias BusinessIntelligence.DataObject

  action_fallback BusinessIntelligenceWeb.FallbackController

  @spec create(any, map) :: {:error, :already_exists | :unexpected_response} | Plug.Conn.t()
  def create(conn, %{"name" => name}) do
    with :ok <- DataObject.create(name) do
      render(conn, "create.json")
    end
  end

  def create(conn, %{"name" => name, "content" => content}) do
    with :ok <- DataObject.create(name, content) do
      render(conn, "create.json")
    end
  end

  @spec show(any, map) :: {:error, :object_not_found | :unexpected_response} | Plug.Conn.t()
  def show(conn, %{"name" => name}) do
    with {:ok, content} <- DataObject.download(name) do
      render(conn, "show.json", data_object: %{name: name, content: content})
    end
  end

  @spec publish(any, map) :: {:error, :object_not_found} | Plug.Conn.t()
  def publish(conn, %{"name" => name}) do
    with {:ok, url} <- DataObject.publish(name) do
      render(conn, "publish.json", data_object: %{name: name, url: url})
    end
  end

  @spec delete(any, map) :: {:error, :object_not_found | :unexpected_response} | Plug.Conn.t()
  def delete(conn, %{"name" => name}) do
    with {:ok, data_objects} <- DataObject.delete(name) do
      render(conn, "delete.json", data_objects: data_objects)
    end
  end
end
