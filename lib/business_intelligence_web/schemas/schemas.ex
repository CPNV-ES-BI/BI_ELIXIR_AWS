defmodule BusinessIntelligenceWeb.Schemas do
  defmodule CreateResponse do
    require OpenApiSpex

    OpenApiSpex.schema(%{
      title: "DataObjectCreateResponse",
      type: :object,
      example: %{
        "data" => %{
          "status" => "created"
        }
      }
    })
  end

  defmodule DownloadResponse do
    require OpenApiSpex

    OpenApiSpex.schema(%{
      title: "DataObjectDownloadResponse",
      type: :string,
      format: :binary,
      example: "dGVzdCBmaWxlIGNvbnRlbnRz"
    })
  end

  defmodule PublishResponse do
    require OpenApiSpex

    OpenApiSpex.schema(%{
      title: "DataObjectPublishResponse",
      type: :object,
      example: %{
        "data" => %{
          "name" => "my_file.json",
          "url" => "https://<AWS_DOMAIN>/<DATA_OBJECT_URL>"
        }
      }
    })
  end

  defmodule DeleteResponse do
    require OpenApiSpex

    OpenApiSpex.schema(%{
      title: "DataObjectDeleteResponse",
      type: :object,
      example: %{
        "data" => %{
          "deleted" => ["my_folder/f1.json", "my_folder/f2.json"]
        }
      }
    })
  end
end
