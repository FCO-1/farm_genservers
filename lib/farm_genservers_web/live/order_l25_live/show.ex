defmodule FarmGenserversWeb.OrderL25Live.Show do
  use FarmGenserversWeb, :live_view

  alias FarmGenservers.Order

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:order_l25, Order.get_order_l25!(id))}
  end

  defp page_title(:show), do: "Show Order l25"
  defp page_title(:edit), do: "Edit Order l25"
end
