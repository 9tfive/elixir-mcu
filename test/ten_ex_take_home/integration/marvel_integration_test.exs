defmodule TenExTakeHome.Api.MarvelIntegrationTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(TenExTakeHome.Repo)
    ExVCR.Config.cassette_library_dir("test/support/fixtures/vcr_cassettes")
    :ok
  end

  setup_all do
    HTTPoison.start()
    :ok
  end

  test "fetches characters from the API" do
    use_cassette "marvel_fetch_characters" do
      offset = 5
      {characters_count, characters} = TenExTakeHome.Api.Marvel.fetch_characters(5)

      assert length(characters) > 0
      assert characters_count > 0

      assert Enum.all?(characters, fn character ->
               Map.has_key?(character, :id) &&
                 Map.has_key?(character, :name) &&
                 Map.has_key?(character, :description) &&
                 Map.has_key?(character, :thumbnail)
             end)

      # Assert data is inserted into the ApiCallTimestamps table
      [inserted_timestamps] = TenExTakeHome.Repo.all(TenExTakeHome.Schema.ApiCallTimestamps)
      assert inserted_timestamps.page_limit == 20
      assert inserted_timestamps.query_offset == (offset - 1) * 20
    end
  end
end
