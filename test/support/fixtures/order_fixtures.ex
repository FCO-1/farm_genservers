defmodule FarmGenservers.OrderFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `FarmGenservers.Order` context.
  """

  @doc """
  Generate a order_l25.
  """
  def order_l25_fixture(attrs \\ %{}) do
    {:ok, order_l25} =
      attrs
      |> Enum.into(%{
        order: 42,
        price: 120.5,
        side: "some side",
        size: 42,
        symbol: "some symbol"
      })
      |> FarmGenservers.Order.create_order_l25()

    order_l25
  end
end
