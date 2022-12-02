defmodule DataObjectTest do
  use ExUnit.Case
  doctest DataObject

  test "DoesExist_ExistsCase_True" do
    # Given
    name = "found"

    # When
    status = DataObject.exists?(name)

    # Then
    assert status == true
  end

  test "DoesExist_NotExists_False" do
    # Given
    name = "not-found"

    # When
    status = DataObject.exists?(name)

    # Then
    refute status
  end

  test "CreateObject_NominalCase_ObjectExists" do
    # Given
    name = "found"

    # When
    result = DataObject.create(name)
    status = DataObject.exists?(name)

    # Then
    assert {:ok, object} = result
    assert status == true
  end

  test "CreateObject_AlreadyExists_ThrowException" do
    # Given
    name = "already-exists"

    # When
    result = DataObject.create(name)

    # Then
    assert {:error, :already_exists} = result
  end

  test "CreateObject_PathNotExists_ObjectExists" do
    # Given
    name = "path-not-exists"

    # When
    result = DataObject.create(name)

    # Then
    assert {:error, :path_not_exists} = result
  end

  test "DownloadObject_NominalCase_Downloaded" do
    # Given
    name = "found"

    # When
    result = DataObject.download(name)

    # Then
    assert {:ok, data_object} = result
  end

  test "DownloadObject_NotExists_ThrowException" do
    # Given
    name = "not-found"

    # When
    result = DataObject.download(name)

    # Then
    assert {:error, :object_not_found} = result
  end

  test "PublishObject_NominalCase_ObjectPublished" do
    # Given
    name = "found"

    # When
    result = DataObject.publish!(name)

    # Then
    assert {:ok, data_object} = result
  end

  test "PublishObject_ObjectNotFound_ThrowException" do
    # Given
    name = "not-found"

    # When
    result = DataObject.publish!(name)

    # Then
    assert {:error, :object_not_found} = result
  end
end
