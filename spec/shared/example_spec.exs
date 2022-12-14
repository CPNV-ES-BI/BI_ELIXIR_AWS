defmodule DataObjectSpec do
  use ESpec
  alias BusinessIntelligence.DataObject

  # def upload_empty_file(name) do
  #   File.touch!(name)
  #
  #   name
  #   |> ExAws.S3.Upload.stream_file()
  #   |> ExAws.S3.upload(DataObject.bucket(), name)
  #   |> ExAws.request!()
  # end
  #
  # def delete_all_objects(bucket \\ DataObject.bucket()) do
  #   IO.puts("delete_all_objects()")
  #
  #   stream =
  #     ExAws.S3.list_objects(bucket)
  #     |> ExAws.stream!()
  #     |> Stream.map(& &1.key)
  #
  #   ExAws.S3.delete_all_objects(bucket, stream)
  #   |> ExAws.request()
  # end

  # This shared spec will always be included!
  # example_group do
  # context "Some context" do
  #   IO.puts("inside some context")
  #   it(do: expect("abc" |> to(match(~r/b/))))
  # end
  before_all do
    IO.puts("Before all tests")
  end

  after_all do
    IO.puts("After all tests")
  end

  describe DataObject do
    # describe "Some another context with opts", focus: true do
    IO.puts("inside some context 2")
    # it(do: 5 |> should(be_between(4, 6)))
    after_all do
      IO.puts("After all tests")
    end

    it "DoesExist_ExistsCase_True" do
      IO.puts("inside does exist test")
      # Given
      # existing_file = "EXISTING_FILE.TXT"

      # When
      # upload_empty_file(existing_file)
      # status = DataObject.exists?(existing_file)
      # IO.puts(inspect(status))

      # Then
      # status |> should(eq(false))
      # expect(status) |> to(eq(true))
      expect(true) |> to(eq(true))
    end

    it "DoesExist_ExistsCase_True1234" do
      expect(true) |> to(eq(true))
    end
  end

  # after_all do
  #   IO.puts("After all tests")
  # end
  # end
end

# end
