defmodule BusinessIntelligence.DataObject do
  require Logger
  import SweetXml

  @moduledoc """
  A simple AWS client that performs some actions on dataobjects.
  """

  def bucket, do: System.fetch_env!("AWS_BUCKET")

  @spec create(binary, any) :: :ok | {:error, :already_exists | :unexpected_response}
  def create(name, content \\ "") do
    if exists?(name) do
      Logger.warn("#{name} already exists")
      Logger.debug("Matching :already_exists")
      {:error, :already_exists}
    else
      result = ExAws.S3.put_object(bucket(), name, content) |> ExAws.request()
      Logger.debug("Got result ==> #{inspect(result)}")

      case result do
        {:ok, %{status_code: 200}} ->
          Logger.info("File #{name} successfully created")
          :ok

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
        |> ExAws.S3.presigned_url(:get, bucket(), name, expires_in: 3600)

      {:ok, url}
    else
      {:error, :object_not_found}
    end
  end

  def delete(name, recusive \\ false) do
    stream =
      ExAws.S3.list_objects(
        bucket(),
        prefix: "#{name}"
      )
      |> ExAws.stream!()
      |> Stream.map(& &1.key)

    # Fetch only the object that matches the name
    # if recusive is set to true
    stream =
      if recusive do
        stream
      else
        stream
        |> Enum.filter(fn file -> file == name end)
      end

    number_of_objects = stream |> Enum.count()

    if number_of_objects <= 0 do
      Logger.error("File #{name} does not exist - delete")
      {:error, :object_not_found}
    else
      result =
        ExAws.S3.delete_all_objects(bucket(), stream)
        |> ExAws.request()

      case result do
        {:ok, [%{body: body, status_code: 200}]} ->
          # For some reason, I receive an XML string instead of a JSON one
          parsed_xml = parse(body)

          deleted_files =
            parsed_xml
            |> SweetXml.xpath(~x"//DeleteResult/Deleted/Key/text()"l)
            |> Enum.map(fn file -> List.to_string(file) end)

          Logger.debug("Deleted files: #{inspect(deleted_files)}")
          {:ok, deleted_files}

        {:error, {:http_error, _, %{status_code: 404}}} ->
          # coveralls-ignore-start
          # In ESpec, you can also test log messages.
          # https://github.com/antonmi/espec#capture_io-and-capture_log
          # For now, we do not want to test them.
          # coveralls-ignore-start
          Logger.error("File #{name} does not exist - delete")
          # coveralls-ignore-stop
          {:error, :object_not_found}

        # Cannot reproduce this error during tests as they rely on AWS infrastructure problems
        # coveralls-ignore-start
        _ ->
          Logger.error("Unexpected response from AWS - delete()")
          {:error, :unexpected_response}
          # coveralls-ignore-stop
      end
    end
  end
end
