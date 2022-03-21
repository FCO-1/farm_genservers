defmodule FarmGenserversWeb.SymbolLiveTest do
  use FarmGenserversWeb.ConnCase

  import Phoenix.LiveViewTest
  import FarmGenservers.CtxsymbolFixtures

  @create_attrs %{name: "some name", provider: "some provider"}
  @update_attrs %{name: "some updated name", provider: "some updated provider"}
  @invalid_attrs %{name: nil, provider: nil}

  defp create_symbol(_) do
    symbol = symbol_fixture()
    %{symbol: symbol}
  end

  describe "Index" do
    setup [:create_symbol]

    test "lists all symbols", %{conn: conn, symbol: symbol} do
      {:ok, _index_live, html} = live(conn, Routes.symbol_index_path(conn, :index))

      assert html =~ "Listing Symbols"
      assert html =~ symbol.name
    end

    test "saves new symbol", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.symbol_index_path(conn, :index))

      assert index_live |> element("a", "New Symbol") |> render_click() =~
               "New Symbol"

      assert_patch(index_live, Routes.symbol_index_path(conn, :new))

      assert index_live
             |> form("#symbol-form", symbol: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#symbol-form", symbol: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.symbol_index_path(conn, :index))

      assert html =~ "Symbol created successfully"
      assert html =~ "some name"
    end

    test "updates symbol in listing", %{conn: conn, symbol: symbol} do
      {:ok, index_live, _html} = live(conn, Routes.symbol_index_path(conn, :index))

      assert index_live |> element("#symbol-#{symbol.id} a", "Edit") |> render_click() =~
               "Edit Symbol"

      assert_patch(index_live, Routes.symbol_index_path(conn, :edit, symbol))

      assert index_live
             |> form("#symbol-form", symbol: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#symbol-form", symbol: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.symbol_index_path(conn, :index))

      assert html =~ "Symbol updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes symbol in listing", %{conn: conn, symbol: symbol} do
      {:ok, index_live, _html} = live(conn, Routes.symbol_index_path(conn, :index))

      assert index_live |> element("#symbol-#{symbol.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#symbol-#{symbol.id}")
    end
  end

  describe "Show" do
    setup [:create_symbol]

    test "displays symbol", %{conn: conn, symbol: symbol} do
      {:ok, _show_live, html} = live(conn, Routes.symbol_show_path(conn, :show, symbol))

      assert html =~ "Show Symbol"
      assert html =~ symbol.name
    end

    test "updates symbol within modal", %{conn: conn, symbol: symbol} do
      {:ok, show_live, _html} = live(conn, Routes.symbol_show_path(conn, :show, symbol))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Symbol"

      assert_patch(show_live, Routes.symbol_show_path(conn, :edit, symbol))

      assert show_live
             |> form("#symbol-form", symbol: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#symbol-form", symbol: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.symbol_show_path(conn, :show, symbol))

      assert html =~ "Symbol updated successfully"
      assert html =~ "some updated name"
    end
  end
end
