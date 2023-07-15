defmodule TenExTakeHome.Api.MarvelTest do
  use ExUnit.Case, async: true

  import Mox

  alias TenExTakeHome.Api.Marvel
  alias TenExTakeHome.Api.MarvelBehaviour


  test "fetches characters from the API" do
    TenExTakeHome.MockMarvelApi
    |> expect(:fetch_characters, fn _page -> {1, []} end)
  end
end
