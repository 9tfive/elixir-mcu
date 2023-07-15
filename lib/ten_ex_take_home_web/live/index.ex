defmodule TenExTakeHomeWeb.PageLive.Index do
  use TenExTakeHomeWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {total_characters_count, characters} = TenExTakeHome.Api.Marvel.fetch_characters()

    socket =
      socket
      |> assign(:total_characters_count, total_characters_count)
      |> assign(:characters, characters)
      |> assign(:page_offset, 0)
      |> assign(:disable_previous, true)
      |> assign(:disable_next, false)
      |> assign(:selected_character, nil)

    {:ok, socket}
  end

  @impl true
  def handle_params(_params, _url, socket) do
    socket =
      socket
      |> assign(:selected_character, nil)

    {:noreply, socket}
  end

  @impl true
  def handle_event("next", _params, socket) do
    page_offset = socket.assigns.page_offset + 20

    {total_characters_count, characters} =
      TenExTakeHome.Api.Marvel.fetch_characters(page_offset / 20 + 1)

    disable_previous = page_offset == 0
    disable_next = page_offset + 20 >= total_characters_count

    socket =
      socket
      |> assign(:characters, characters)
      |> assign(:page_offset, page_offset)
      |> assign(:disable_previous, disable_previous)
      |> assign(:disable_next, disable_next)
      |> assign(:selected_character, nil)

    {:noreply, socket}
  end

  @impl true
  def handle_event("previous", _params, socket) do
    page_offset = socket.assigns.page_offset - 20

    {_, characters} =
      TenExTakeHome.Api.Marvel.fetch_characters(page_offset / 20 + 1)

    disable_previous = page_offset == 0
    disable_next = false

    socket =
      socket
      |> assign(:characters, characters)
      |> assign(:page_offset, page_offset)
      |> assign(:disable_previous, disable_previous)
      |> assign(:disable_next, disable_next)
      |> assign(:selected_character, nil)

    {:noreply, socket}
  end

  @impl true
  def handle_event("show_character", %{"character" => character}, socket) do
    socket =
      socket
      |> assign(:selected_character, character |> Jason.decode!(keys: :atoms))

    {:noreply, socket}
  end
end
