defmodule TenExTakeHome.Api.MarvelBehaviour do
  @callback fetch_characters(integer()) :: {integer(), list(map())}
end
