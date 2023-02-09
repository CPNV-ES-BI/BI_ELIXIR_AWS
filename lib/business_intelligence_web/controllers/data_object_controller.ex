defmodule BusinessIntelligenceWeb.DataObjectController do
  use OpenApiSpex.ControllerSpecs
  use BusinessIntelligenceWeb, :controller
  alias BusinessIntelligence.DataObject

  alias BusinessIntelligenceWeb.Schemas.{
    CreateResponse,
    DeleteResponse,
    DownloadResponse,
    PublishResponse
  }

  require Logger

  action_fallback(BusinessIntelligenceWeb.FallbackController)

  operation(:create,
    summary: "Create a data object with given content",
    request_body: {"Uploaded data object", "multipart/form-data"},
    responses: [
      ok: {"Create response", "application/json", CreateResponse}
    ]
  )

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

  operation(:show,
    summary: "Download data object",
    parameters: [
      "Content-Type": [
        in: :header,
        type: :string,
        description: "The type of file you want to download"
      ],
      name: [
        in: :path,
        description: "Data object name (without extension)",
        type: :string,
        example: "my_file"
      ],
      path: [in: :query, type: :string, description: "Full path of the data object(s)"]
    ],
    responses: [
      ok: {
        "File content",
        "application/octet-stream",
        DownloadResponse
      }
    ]
  )

  @spec show(any, map) :: {:error, :object_not_found | :unexpected_response} | Plug.Conn.t()
  def show(conn, %{"name" => name} = params) do
    name = if Map.has_key?(params, "path"), do: "#{params["path"]}/#{name}", else: name

    with {:ok, fullname, content_type} <- fetch_fullname(conn, name) do
      with {:ok, content} <- DataObject.download(fullname) do
        conn
        |> put_resp_content_type(content_type)
        |> put_resp_header("content-disposition", "attachment; filename=\"#{fullname}\"")
        |> send_resp(200, content)
      end
    end
  end

  operation(:publish,
    summary: "Publish a data object for 1h",
    parameters: [
      "Content-Type": [
        in: :header,
        type: :string,
        description: "The type of file you want to publish"
      ],
      name: [in: :path, description: "Data object(s)", type: :string, example: "my_file"],
      path: [in: :query, type: :string, description: "Full path of the data object(s)"]
    ],
    responses: [
      ok: {"Deleted files", "application/json", PublishResponse}
    ]
  )

  @spec publish(any, map) :: {:error, :object_not_found} | Plug.Conn.t()
  def publish(conn, %{"name" => name} = params) do
    name = if Map.has_key?(params, "path"), do: "#{params["path"]}/#{name}", else: name

    with {:ok, fullname, _content_type} <- fetch_fullname(conn, name) do
      with {:ok, url} <- DataObject.publish(fullname) do
        render(conn, "publish.json", data_object: %{name: fullname, url: url})
      end
    end
  end

  operation(:delete,
    summary: "Delete data object(s)",
    parameters: [
      "Content-Type": [
        in: :header,
        type: :string,
        description: "The type of file you want to delete"
      ],
      name: [in: :path, description: "Data object(s)", type: :string, example: "my_file"],
      recursive: [in: :query, type: :boolean, description: "Delete data objects recursively"],
      path: [in: :query, type: :string, description: "Full path of the data object(s)"]
    ],
    responses: [
      ok: {"Deleted files", "application/json", DeleteResponse}
    ]
  )

  @spec delete(any, map) :: {:error, :object_not_found | :unexpected_response} | Plug.Conn.t()
  def delete(conn, %{"name" => name} = params) do
    name = if Map.has_key?(params, "path"), do: "#{params["path"]}/#{name}", else: name

    recursive =
      if Map.has_key?(params, "recursive") do
        recursive = params["recursive"] |> String.downcase()
        if recursive == "true", do: true, else: false
      else
        false
      end

    Logger.debug("Delete recursive: #{inspect(recursive)}")

    with {:ok, fullname, _content_type} <- fetch_fullname(conn, name) do
      with {:ok, data_objects} <- DataObject.delete(fullname, recursive) do
        render(conn, "delete.json", data_objects: data_objects)
      end
    end
  end

  defp fetch_fullname(conn, name) do
    content_type = get_req_header(conn, "content-type")

    if Enum.count(content_type) > 0 do
      extension = MIME.extensions(content_type |> Enum.at(0)) |> Enum.at(0)
      {:ok, "#{name}.#{extension}", content_type |> Enum.at(0)}
    else
      {:error, :bad_request}
    end
  end
end
