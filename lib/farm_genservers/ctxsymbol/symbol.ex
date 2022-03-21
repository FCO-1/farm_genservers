defmodule FarmGenservers.Ctxsymbol.Symbol do
  use Ecto.Schema
  import Ecto.Changeset

  schema "symbols" do
    field :name, :string
    field :provider, :string

    timestamps()
  end

  @doc false
  def changeset(symbol, attrs) do
    symbol
    |> cast(attrs, [:name, :provider])
    |> validate_required([:name, :provider])
  end
end
