defmodule FarmGenserversWeb.OrderL25LiveTest do
  use FarmGenserversWeb.ConnCase

  import Phoenix.LiveViewTest
  import FarmGenservers.OrderFixtures

  @create_attrs %{order: 42, price: 120.5, side: "some side", size: 42, symbol: "some symbol"}
  @update_attrs %{order: 43, price: 456.7, side: "some updated side", size: 43, symbol: "some updated symbol"}
  @invalid_attrs %{order: nil, price: nil, side: nil, size: nil, symbol: nil}

  defp create_order_l25(_) do
    order_l25 = order_l25_fixture()
    %{order_l25: order_l25}
  end

  describe "Index" do
    setup [:create_order_l25]

    test "lists all orders_l25", %{conn: conn, order_l25: order_l25} do
      {:ok, _index_live, html} = live(conn, Routes.order_l25_index_path(conn, :index))

      assert html =~ "Listing Orders l25"
      assert html =~ order_l25.side
    end

    test "saves new order_l25", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.order_l25_index_path(conn, :index))

      assert index_live |> element("a", "New Order l25") |> render_click() =~
               "New Order l25"

      assert_patch(index_live, Routes.order_l25_index_path(conn, :new))

      assert index_live
             |> form("#order_l25-form", order_l25: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#order_l25-form", order_l25: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.order_l25_index_path(conn, :index))

      assert html =~ "Order l25 created successfully"
      assert html =~ "some side"
    end

    test "updates order_l25 in listing", %{conn: conn, order_l25: order_l25} do
      {:ok, index_live, _html} = live(conn, Routes.order_l25_index_path(conn, :index))

      assert index_live |> element("#order_l25-#{order_l25.id} a", "Edit") |> render_click() =~
               "Edit Order l25"

      assert_patch(index_live, Routes.order_l25_index_path(conn, :edit, order_l25))

      assert index_live
             |> form("#order_l25-form", order_l25: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#order_l25-form", order_l25: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.order_l25_index_path(conn, :index))

      assert html =~ "Order l25 updated successfully"
      assert html =~ "some updated side"
    end

    test "deletes order_l25 in listing", %{conn: conn, order_l25: order_l25} do
      {:ok, index_live, _html} = live(conn, Routes.order_l25_index_path(conn, :index))

      assert index_live |> element("#order_l25-#{order_l25.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#order_l25-#{order_l25.id}")
    end
  end

  describe "Show" do
    setup [:create_order_l25]

    test "displays order_l25", %{conn: conn, order_l25: order_l25} do
      {:ok, _show_live, html} = live(conn, Routes.order_l25_show_path(conn, :show, order_l25))

      assert html =~ "Show Order l25"
      assert html =~ order_l25.side
    end

    test "updates order_l25 within modal", %{conn: conn, order_l25: order_l25} do
      {:ok, show_live, _html} = live(conn, Routes.order_l25_show_path(conn, :show, order_l25))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Order l25"

      assert_patch(show_live, Routes.order_l25_show_path(conn, :edit, order_l25))

      assert show_live
             |> form("#order_l25-form", order_l25: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#order_l25-form", order_l25: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.order_l25_show_path(conn, :show, order_l25))

      assert html =~ "Order l25 updated successfully"
      assert html =~ "some updated side"
    end
  end
end
