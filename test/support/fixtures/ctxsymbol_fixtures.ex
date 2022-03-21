defmodule FarmGenservers.CtxsymbolFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `FarmGenservers.Ctxsymbol` context.
  """

  @doc """
  Generate a symbol.
  """
  def symbol_fixture(attrs \\ %{}) do
    {:ok, symbol} =
      attrs
      |> Enum.into(%{
        name: "some name",
        provider: "some provider"
      })
      |> FarmGenservers.Ctxsymbol.create_symbol()

    symbol
  end
end
