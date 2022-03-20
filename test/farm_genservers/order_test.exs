defmodule FarmGenservers.OrderTest do
  use FarmGenservers.DataCase

  alias FarmGenservers.Order

  describe "orders_l25" do
    alias FarmGenservers.Order.OrderL25

    import FarmGenservers.OrderFixtures

    @invalid_attrs %{order: nil, price: nil, side: nil, size: nil, symbol: nil}

    test "list_orders_l25/0 returns all orders_l25" do
      order_l25 = order_l25_fixture()
      assert Order.list_orders_l25() == [order_l25]
    end

    test "get_order_l25!/1 returns the order_l25 with given id" do
      order_l25 = order_l25_fixture()
      assert Order.get_order_l25!(order_l25.id) == order_l25
    end

    test "create_order_l25/1 with valid data creates a order_l25" do
      valid_attrs = %{order: 42, price: 120.5, side: "some side", size: 42, symbol: "some symbol"}

      assert {:ok, %OrderL25{} = order_l25} = Order.create_order_l25(valid_attrs)
      assert order_l25.order == 42
      assert order_l25.price == 120.5
      assert order_l25.side == "some side"
      assert order_l25.size == 42
      assert order_l25.symbol == "some symbol"
    end

    test "create_order_l25/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Order.create_order_l25(@invalid_attrs)
    end

    test "update_order_l25/2 with valid data updates the order_l25" do
      order_l25 = order_l25_fixture()
      update_attrs = %{order: 43, price: 456.7, side: "some updated side", size: 43, symbol: "some updated symbol"}

      assert {:ok, %OrderL25{} = order_l25} = Order.update_order_l25(order_l25, update_attrs)
      assert order_l25.order == 43
      assert order_l25.price == 456.7
      assert order_l25.side == "some updated side"
      assert order_l25.size == 43
      assert order_l25.symbol == "some updated symbol"
    end

    test "update_order_l25/2 with invalid data returns error changeset" do
      order_l25 = order_l25_fixture()
      assert {:error, %Ecto.Changeset{}} = Order.update_order_l25(order_l25, @invalid_attrs)
      assert order_l25 == Order.get_order_l25!(order_l25.id)
    end

    test "delete_order_l25/1 deletes the order_l25" do
      order_l25 = order_l25_fixture()
      assert {:ok, %OrderL25{}} = Order.delete_order_l25(order_l25)
      assert_raise Ecto.NoResultsError, fn -> Order.get_order_l25!(order_l25.id) end
    end

    test "change_order_l25/1 returns a order_l25 changeset" do
      order_l25 = order_l25_fixture()
      assert %Ecto.Changeset{} = Order.change_order_l25(order_l25)
    end
  end
end
