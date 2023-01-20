defmodule BusinessIntelligenceWeb.DataObjectController do
  use BusinessIntelligenceWeb, :controller
  alias BusinessIntelligence.DataObject

  require Logger

  action_fallback(BusinessIntelligenceWeb.FallbackController)

  @spec create(any, map) :: {:error, :already_exists | :unexpected_response} | Plug.Conn.t()
  def create(conn, %{"name" => name}) do
    with :ok <- DataObject.create(name) do
      render(conn, "create.json")
    end
  end

  def create(conn, %{"file" => file}) do
    content = File.read!(file.path)

    with :ok <- DataObject.create(file.filename, content) do
      render(conn, "create.json")
    end
  end

  @spec show(any, map) :: {:error, :object_not_found | :unexpected_response} | Plug.Conn.t()
  def show(conn, %{"name" => name}) do
    content_type = get_req_header(conn, "content-type") |> Enum.at(0)
    extension = MIME.extensions(content_type) |> Enum.at(0)

    with {:ok, content} <- DataObject.download("#{name}.#{extension}") do
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
