defmodule FarmGenserversWeb.SymbolLive.Show do
  use FarmGenserversWeb, :live_view

  alias FarmGenservers.Ctxsymbol

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:symbol, Ctxsymbol.get_symbol!(id))}
  end

  defp page_title(:show), do: "Show Symbol"
  defp page_title(:edit), do: "Edit Symbol"
end
