defmodule FarmGenservers.Order.OrderL25 do
  use Ecto.Schema
  import Ecto.Changeset

  schema "orders_l25" do
    field :order, :decimal
    field :price, :decimal
    field :side, :string
    field :size, :integer
    field :symbol, :string

    timestamps()
  end

  @doc false
  def changeset(order_l25, attrs) do
    order_l25
    |> cast(attrs, [:order, :price, :side, :size, :symbol])
    |> validate_required([:order, :price, :side, :size, :symbol])
  end
end
