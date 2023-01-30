defmodule DataObjectSpec do
  # use ESpec, shared: true
  use ESpec
  require Logger
  alias BusinessIntelligence.DataObject

  @exist_dir "exist"
  @upload_dir "upload"
  @download_dir "download"
  @publish_dir "publish"
  @delete_dir "delete"

  describe "Upload files using a helper and check if they exist" do
    before do
      DataObject.delete(@exist_dir, true)
      DataObject.create("#{@exist_dir}/EXISTING_FILE.txt")
    end

    it "DoesExist_ExistsCase_True" do
      # Given
      existing_file = "#{@exist_dir}/EXISTING_FILE.TXT"

      # When
      DataObject.create(existing_file)
      status = DataObject.exists?(existing_file)

      # Then
      assert status == true
    end

    it "DoesExist_NotExists_False" do
      # Given
      non_existing_file = "#{@exist_dir}/NON_EXISTING_FILE.TXT"

      # When
      status = DataObject.exists?(non_existing_file)

      # Then
      assert status == false
    end

    finally do
      Logger.info("Deleting all files in #{@exist_dir}")
      DataObject.delete(@exist_dir, true)
    end
  end

  describe "Create files and check if they exist" do
    before do
      DataObject.delete(@upload_dir, true)
      DataObject.create("#{@upload_dir}/ALREADY_EXISTING_FILE.txt")
    end

    it "CreateObject_NominalCase_ObjectExists" do
      # Given
      existing_file = "#{@upload_dir}/EXISTING_FILE.TXT"

      # When
      result = DataObject.create(existing_file)
      status = DataObject.exists?(existing_file)

      # Then
      assert :ok = result
      assert status == true
    end

    it "CreateObject_AlreadyExists_ThrowException" do
      # Given
      name = "#{@upload_dir}/ALREADY_EXISTING_FILE.txt"

      # When
      result = DataObject.create(name)

      # Then
      assert {:error, :already_exists} = result
    end

    it "CreateObject_PathNotExists_ObjectExists" do
      # Given
      name = "#{@upload_dir}/path/to/file/NON_EXISTING_FILE.txt"

      # When
      result = DataObject.create(name)

      # Then
      assert :ok = result
    end

    finally do
      Logger.info("Deleting all files in #{@upload_dir}")
      DataObject.delete(@upload_dir, true)
    end
  end

  describe "Upload and download files" do
    before do
      DataObject.delete(@download_dir, true)
      DataObject.create("#{@download_dir}/EXISTING_FILE.txt", "Some content")
    end

    it "DownloadObject_NominalCase_Downloaded" do
      # Given
      existing_file = "#{@download_dir}/EXISTING_FILE.txt"

      # When
      status = DataObject.download(existing_file)

      # Then
      assert {:ok, _object} = status
    end

    it "DownloadObject_NotExists_ThrowException" do
      # Given
      non_existing_file = "#{@download_dir}/NON_EXISTING_FILE.txt"

      # When
      status = DataObject.download(non_existing_file)

      # Then
      assert {:error, :object_not_found} = status
    end

    finally do
      Logger.info("Deleting all files in #{@download_dir}")
      DataObject.delete(@download_dir, true)
    end
  end

  describe "Upload and publish files" do
    before do
      DataObject.delete(@publish_dir, true)
      DataObject.create("#{@publish_dir}/EXISTING_FILE.txt", "Some content")
    end

    it "PublishObject_NominalCase_ObjectPublished" do
      # Given
      existing_file = "#{@publish_dir}/EXISTING_FILE.txt"

      # When
      status = DataObject.publish(existing_file)

      # Then
      assert {:ok, _object} = status
    end

    it "PublishObject_ObjectNotFound_ThrowException" do
      # Given
      non_existing_file = "#{@publish_dir}/NON_EXISTING_FILE.txt"

      # When
      status = DataObject.publish(non_existing_file)

      # Then
      assert {:error, :object_not_found} = status
    end

    finally do
      Logger.info("Deleting all files in #{@publish_dir}")
      DataObject.delete(@publish_dir, true)
    end
  end

  describe "Upload and delete files" do
    before do
      DataObject.delete(@delete_dir, true)
    end

    it "DeleteObject_ObjectExists_ObjectDeleted" do
      # Given
      existing_file = "#{@delete_dir}/EXISTING_FILE.txt"
      :ok = DataObject.create(existing_file)

      # When
      status = DataObject.delete(existing_file)

      # Then
      assert {:ok, [_existing_file]} = status
    end

    it "DeleteObject_ObjectContainingSubObjectsExists_ObjectDeletedRecursively" do
      # Given
      existing_file_1 = "#{@delete_dir}/EXISTING_FILE_1.txt"
      existing_file_2 = "#{@delete_dir}/EXISTING_FILE_2.txt"
      :ok = DataObject.create(existing_file_1)
      :ok = DataObject.create(existing_file_2)

      # When
      status = DataObject.delete("#{@delete_dir}", recursive: true)

      # Then
      assert {:ok, files} = status
      assert Enum.count(files) == 2
    end

    it "DeleteObject_ObjectDoesntExist_ThrowException" do
      # Given
      non_existing_file = "#{@delete_dir}/NON_EXISTING_FILE.txt"

      # When
      status = DataObject.delete(non_existing_file)

      # Then
      assert {:error, :object_not_found} = status
    end

    it "DeleteObject_ObjectDoesntExistRecursively_ThrowException" do
      # Given
      non_existing_file = "#{@delete_dir}/NON_EXISTING_FILE.txt"

      # When
      status = DataObject.delete(non_existing_file, recursive: true)

      # Then
      assert {:error, :object_not_found} = status
    end

    finally do
      Logger.info("Deleting all files in #{@delete_dir}")
      DataObject.delete(@delete_dir, true)
    end
  end
end
