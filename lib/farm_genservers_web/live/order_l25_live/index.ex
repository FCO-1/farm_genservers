defmodule FarmGenserversWeb.OrderL25Live.Index do
  use FarmGenserversWeb, :live_view

  alias FarmGenservers.Order
  alias FarmGenservers.Order.OrderL25

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :orders_l25, list_orders_l25())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Order l25")
    |> assign(:order_l25, Order.get_order_l25!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Order l25")
    |> assign(:order_l25, %OrderL25{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Orders l25")
    |> assign(:order_l25, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    order_l25 = Order.get_order_l25!(id)
    {:ok, _} = Order.delete_order_l25(order_l25)

    {:noreply, assign(socket, :orders_l25, list_orders_l25())}
  end

  defp list_orders_l25 do
    Order.list_orders_l25()
  end
end
