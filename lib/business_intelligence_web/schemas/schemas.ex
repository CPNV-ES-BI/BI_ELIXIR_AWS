defmodule BusinessIntelligenceWeb.Schemas do
  defmodule CreateResponse do
    @moduledoc """
    Create Response OpenAPI schema
    """
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
    @moduledoc """
    Download Response OpenAPI schema
    """
    require OpenApiSpex

    OpenApiSpex.schema(%{
      title: "DataObjectDownloadResponse",
      type: :string,
      format: :binary,
      example: "dGVzdCBmaWxlIGNvbnRlbnRz"
    })
  end

  defmodule PublishRequest do
    @moduledoc """
    Publish Request OpenAPI schema
    """
    require OpenApiSpex

    OpenApiSpex.schema(%{
      title: "DataObjectPublishRequest",
      type: :object,
      example: %{
        "timeout" => 3600
      }
    })
  end

  defmodule PublishResponse do
    @moduledoc """
    Publish Response OpenAPI schema
    """
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
    @moduledoc """
    Delete Response OpenAPI schema
    """
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
