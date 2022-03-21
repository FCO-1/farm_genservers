defmodule FarmGenserversWeb.SymbolLive.FormComponent do
  use FarmGenserversWeb, :live_component

  alias FarmGenservers.Ctxsymbol

  @impl true
  def update(%{symbol: symbol} = assigns, socket) do
    changeset = Ctxsymbol.change_symbol(symbol)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"symbol" => symbol_params}, socket) do
    changeset =
      socket.assigns.symbol
      |> Ctxsymbol.change_symbol(symbol_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"symbol" => symbol_params}, socket) do
    save_symbol(socket, socket.assigns.action, symbol_params)
  end

  defp save_symbol(socket, :edit, symbol_params) do
    case Ctxsymbol.update_symbol(socket.assigns.symbol, symbol_params) do
      {:ok, _symbol} ->
        {:noreply,
         socket
         |> put_flash(:info, "Symbol updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_symbol(socket, :new, symbol_params) do
    case Ctxsymbol.create_symbol(symbol_params) do
      {:ok, _symbol} ->
        {:noreply,
         socket
         |> put_flash(:info, "Symbol created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
