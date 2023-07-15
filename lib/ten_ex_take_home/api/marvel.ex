defmodule TenExTakeHome.Api.Marvel do
  @api_base_url "http://gateway.marvel.com/v1/public/characters"
  @keys_to_keep [:id, :name, :description, :thumbnail]
  @default_limit 20
  @cache_name :characters_cache

  def fetch_characters(page \\ 1) do
    with {:ok, nil} <- Cachex.get(@cache_name, page) do
      fetch_characters_from_api(page)
    end
    |> handle_fetch_cache()
  end

  def fetch_characters_from_api(page) do
    url = build_url(page)
    headers = build_headers()

    case HTTPoison.get(url, headers) do
      {:ok, %{body: body}} ->
        api_analytics(page)

        {page, parse_response(body)}

      {:error, response} ->
        api_analytics(page, response.reason)
        {:error, response}
    end
  end

  defp handle_fetch_cache({:error, _reason}), do: {nil, []}

  defp handle_fetch_cache({:ok, characters}),
    do: {Cachex.get!(@cache_name, :total_characters_count), characters}

  defp handle_fetch_cache({page, {count, characters}}) do
    Cachex.put(@cache_name, page, characters)
    Cachex.put(@cache_name, :total_characters_count, count)
    {count, characters}
  end

  defp build_url(page) do
    ts = Integer.to_string(System.system_time(:second))

    # Generate the hash
    hash =
      :crypto.hash(:md5, "#{ts}#{get_private_key()}#{get_api_key()}")
      |> Base.encode16()
      |> String.downcase()

    "#{@api_base_url}?ts=#{ts}&apikey=#{get_api_key()}&hash=#{hash}&offset=#{page_offset(page)}&limit=#{@default_limit}"
  end

  defp api_analytics(page, reason \\ nil),
    do:
      %{
        timestamp: DateTime.utc_now() |> DateTime.truncate(:second),
        query_offset: page_offset(page) |> trunc,
        page_limit: @default_limit,
        error_reason: reason
      }
      |> TenExTakeHome.Schema.ApiCallTimestamps.create_timestamp()

  defp page_offset(page), do: @default_limit * (page - 1)

  defp parse_response(response), do: Jason.decode(response, keys: :atoms) |> filter_characters

  defp filter_characters({:ok, %{data: %{total: total, results: characters}}}) do
    characters =
      Enum.map(characters, fn character ->
        Map.take(character, @keys_to_keep)
      end)

    {total, characters}
  end

  defp build_headers, do: [{"Content-Type", "application/json"}]

  defp get_api_key, do: Application.get_env(:ten_ex_take_home, :marvel_api)[:public_key]

  defp get_private_key, do: Application.get_env(:ten_ex_take_home, :marvel_api)[:private_key]
end
