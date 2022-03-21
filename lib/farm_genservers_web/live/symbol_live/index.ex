defmodule FarmGenserversWeb.SymbolLive.Index do
  use FarmGenserversWeb, :live_view

  alias FarmGenservers.Ctxsymbol
  alias FarmGenservers.Ctxsymbol.Symbol

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :symbols, list_symbols())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Symbol")
    |> assign(:symbol, Ctxsymbol.get_symbol!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Symbol")
    |> assign(:symbol, %Symbol{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Symbols")
    |> assign(:symbol, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    symbol = Ctxsymbol.get_symbol!(id)
    {:ok, _} = Ctxsymbol.delete_symbol(symbol)

    {:noreply, assign(socket, :symbols, list_symbols())}
  end

  defp list_symbols do
    Ctxsymbol.list_symbols()
  end
end
