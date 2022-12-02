defmodule DataObject do
  def create(name) do
    case name do
      "found" ->
        {:ok, %{}}

      "already-exists" ->
        {:error, :already_exists}

      "path-not-exists" ->
        {:error, :path_not_exists}
    end
  end

  def exists?(name) do
    if name == "found" do
      true
    else
      false
    end
  end

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
