defmodule BusinessIntelligence.DataObject do
  require Logger

  def bucket(), do: System.fetch_env!("AWS_BUCKET")

  @spec create(<<_::40, _::_*8>>) :: {:error, :already_exists} | {:ok, %{}}
  def create(name, content \\ "") do
    if not exists?(name) do
      result = ExAws.S3.put_object(bucket(), name, content) |> ExAws.request()

      case result do
        {:ok, %{status_code: 200}} ->
          Logger.info("File #{name} successfully created")
          {:ok, %{}}

        {:error, %{status_code: 404}} ->
          Logger.error("File #{name} does not exist")
          false

        _ ->
          Logger.error("Unexpected response from AWS")
          {:error, :unexpected_response}
      end
    else
      Logger.warn("#{name} already exists")
      {:error, :already_exists}
    end
  end

  @spec exists?(any) :: boolean
  def exists?(name) do
    Logger.debug("Checking if #{name} exists")

    result =
      ExAws.S3.head_object(bucket(), name)
      |> ExAws.request()

    case result do
      {:ok, %{status_code: 200}} ->
        Logger.info("File #{name} exists")
        true

      {:error, {:http_error, _, %{status_code: 404}}} ->
        Logger.error("File #{name} does not exist")
        false

      _ ->
        Logger.error("Unexpected response from AWS - exists?()")
        false
    end
  end

  @spec download(any) :: {:error, :object_not_found} | {:ok, %{}}
  def download(name) do
    if name == "found" do
      {:ok, %{}}
    else
      {:error, :object_not_found}
    end
  end

  def publish!(name) do
    if name == "found" do
      {:ok, %{}}
    else
      {:error, :object_not_found}
    end
  end
end
