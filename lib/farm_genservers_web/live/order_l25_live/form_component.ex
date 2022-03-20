defmodule FarmGenserversWeb.OrderL25Live.FormComponent do
  use FarmGenserversWeb, :live_component

  alias FarmGenservers.Order

  @impl true
  def update(%{order_l25: order_l25} = assigns, socket) do
    changeset = Order.change_order_l25(order_l25)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"order_l25" => order_l25_params}, socket) do
    changeset =
      socket.assigns.order_l25
      |> Order.change_order_l25(order_l25_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"order_l25" => order_l25_params}, socket) do
    save_order_l25(socket, socket.assigns.action, order_l25_params)
  end

  defp save_order_l25(socket, :edit, order_l25_params) do
    case Order.update_order_l25(socket.assigns.order_l25, order_l25_params) do
      {:ok, _order_l25} ->
        {:noreply,
         socket
         |> put_flash(:info, "Order l25 updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_order_l25(socket, :new, order_l25_params) do
    case Order.create_order_l25(order_l25_params) do
      {:ok, _order_l25} ->
        {:noreply,
         socket
         |> put_flash(:info, "Order l25 created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
