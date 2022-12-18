defmodule BusinessIntelligence.DataObject do
  require Logger

  @moduledoc """
  A simple AWS client that performs some actions on dataobjects.
  """

  def bucket, do: System.fetch_env!("AWS_BUCKET")

  @spec create(<<_::40, _::_*8>>) :: {:error, :already_exists} | {:ok, %{}}
  def create(name, content \\ "") do
    if exists?(name) do
      Logger.warn("#{name} already exists")
      {:error, :already_exists}
    else
      result = ExAws.S3.put_object(bucket(), name, content) |> ExAws.request()

      case result do
        {:ok, %{status_code: 200}} ->
          Logger.info("File #{name} successfully created")
          {:ok, %{}}

        # Cannot reproduce this error during tests as they rely on AWS infrastructure problems
        # coveralls-ignore-start
        _ ->
          Logger.error("Unexpected response from AWS")
          {:error, :unexpected_response}
          # coveralls-ignore-stop
      end
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

      # Cannot reproduce this error during tests as they rely on AWS infrastructure problems
      # coveralls-ignore-start
      _ ->
        Logger.error("Unexpected response from AWS - exists?()")
        false
        # coveralls-ignore-stop
    end
  end

  @spec download(binary) :: {:error, :object_not_found | :unexpected_response} | {:ok, any}
  def download(name) do
    result = ExAws.S3.get_object(bucket(), name) |> ExAws.request()

    case result do
      {:ok, %{body: body, status_code: 200}} ->
        Logger.info("File #{name} downloaded")
        {:ok, body}

      {:error, {:http_error, _, %{status_code: 404}}} ->
        Logger.error("File #{name} does not exist - download")
        {:error, :object_not_found}

      # Cannot reproduce this error during tests as they rely on AWS infrastructure problems
      # coveralls-ignore-start
      _ ->
        Logger.error("Unexpected response from AWS - download()")
        {:error, :unexpected_response}
        # coveralls-ignore-stop
    end
  end

  def publish(name) do
    if exists?(name) do
      {:ok, url} =
        ExAws.Config.new(:s3)
        |> ExAws.S3.presigned_url(:get_object, bucket(), name, expires_in: 3600)

      {:ok, url}
    else
      {:error, :object_not_found}
    end
  end
end
