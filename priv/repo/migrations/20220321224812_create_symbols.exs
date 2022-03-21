defmodule FarmGenservers.Repo.Migrations.CreateSymbols do
  use Ecto.Migration

  def change do
    create table(:symbols) do
      add :name, :string
      add :provider, :string

      timestamps()
    end
  end
end
