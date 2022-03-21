defmodule FarmGenservers.CtxsymbolTest do
  use FarmGenservers.DataCase

  alias FarmGenservers.Ctxsymbol

  describe "symbols" do
    alias FarmGenservers.Ctxsymbol.Symbol

    import FarmGenservers.CtxsymbolFixtures

    @invalid_attrs %{name: nil, provider: nil}

    test "list_symbols/0 returns all symbols" do
      symbol = symbol_fixture()
      assert Ctxsymbol.list_symbols() == [symbol]
    end

    test "get_symbol!/1 returns the symbol with given id" do
      symbol = symbol_fixture()
      assert Ctxsymbol.get_symbol!(symbol.id) == symbol
    end

    test "create_symbol/1 with valid data creates a symbol" do
      valid_attrs = %{name: "some name", provider: "some provider"}

      assert {:ok, %Symbol{} = symbol} = Ctxsymbol.create_symbol(valid_attrs)
      assert symbol.name == "some name"
      assert symbol.provider == "some provider"
    end

    test "create_symbol/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Ctxsymbol.create_symbol(@invalid_attrs)
    end

    test "update_symbol/2 with valid data updates the symbol" do
      symbol = symbol_fixture()
      update_attrs = %{name: "some updated name", provider: "some updated provider"}

      assert {:ok, %Symbol{} = symbol} = Ctxsymbol.update_symbol(symbol, update_attrs)
      assert symbol.name == "some updated name"
      assert symbol.provider == "some updated provider"
    end

    test "update_symbol/2 with invalid data returns error changeset" do
      symbol = symbol_fixture()
      assert {:error, %Ecto.Changeset{}} = Ctxsymbol.update_symbol(symbol, @invalid_attrs)
      assert symbol == Ctxsymbol.get_symbol!(symbol.id)
    end

    test "delete_symbol/1 deletes the symbol" do
      symbol = symbol_fixture()
      assert {:ok, %Symbol{}} = Ctxsymbol.delete_symbol(symbol)
      assert_raise Ecto.NoResultsError, fn -> Ctxsymbol.get_symbol!(symbol.id) end
    end

    test "change_symbol/1 returns a symbol changeset" do
      symbol = symbol_fixture()
      assert %Ecto.Changeset{} = Ctxsymbol.change_symbol(symbol)
    end
  end
end
