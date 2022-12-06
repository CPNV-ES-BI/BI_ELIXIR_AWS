defmodule BusinessIntelligence.DataObject do
  @spec create(<<_::40, _::_*8>>) :: {:error, :already_exists | :path_not_exists} | {:ok, %{}}
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

  @spec exists?(any) :: boolean
  def exists?(name) do
    if name == "found" do
      true
    else
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
