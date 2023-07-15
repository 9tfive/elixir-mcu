defmodule TenExTakeHomeWeb.Components.CharacterComponent do
    use TenExTakeHomeWeb, :live_component
  
    @impl true
    def render(assigns) do
      ~H"""
      <div>
        <.header>
          <div class="text-white bg-gray-800 rounded-md hover:bg-gray-900 dark:bg-gray-800 dark:border-gray-700 dark:text-gray-400 dark:hover:bg-gray-700 dark:hover:text-white p-4 border border-gray-300 transform hover:scale-105 transition-transform duration-300">
            <img
              src={"#{assigns.character.thumbnail.path}.#{assigns.character.thumbnail.extension}"}
              alt={assigns.character.name}
              class="w-full h-auto rounded-md"
            />
            <p class="text-center text-white mt-2 font-bold"><%= assigns.character.name %></p>
            <hr class="h-1 bg-gray-200 border-0 rounded dark:bg-gray-700">
            <p class="text-center text-white mt-2 font-normal text-sm"><%= assigns.character.description %></p>
          </div>
        </.header>
      </div>
      """
    end
  
    @impl true
    def update(assigns, socket) do
      {:ok,
       socket
       |> assign(assigns)}
    end
  end
  