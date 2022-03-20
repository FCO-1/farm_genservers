defmodule FarmGenservers.Repo.Migrations.CreateOrdersL25 do
  use Ecto.Migration

  def change do
    create table(:orders_l25) do
      add :order, :numeric
      add :price, :decimal
      add :side, :string
      add :size, :integer
      add :symbol, :string

      timestamps()
    end

    execute("ALTER TABLE orders_l25 ALTER COLUMN inserted_at SET DEFAULT now();","")
    execute("ALTER TABLE orders_l25 ALTER COLUMN updated_at SET DEFAULT now();","")
  end
end
