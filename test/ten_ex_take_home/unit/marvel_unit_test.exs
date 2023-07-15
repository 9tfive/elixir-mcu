defmodule TenExTakeHome.Api.MarvelTest do
  use ExUnit.Case, async: true

  import Mox

  test "fetches characters from the API" do
    TenExTakeHome.MockMarvelApi
    |> expect(:fetch_characters, fn _page -> {1, []} end)
  end
end
