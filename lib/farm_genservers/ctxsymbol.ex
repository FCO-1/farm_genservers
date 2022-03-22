defmodule FarmGenservers.Ctxsymbol do
  @moduledoc """
  The Ctxsymbol context.
  """

  import Ecto.Query, warn: false
  alias FarmGenservers.Repo

  alias FarmGenservers.Ctxsymbol.Symbol

  @doc """
  Returns the list of symbols.

  ## Examples

      iex> list_symbols()
      [%Symbol{}, ...]

  """

  def launch_symbols do
    symbols = list_symbols()

      Enum.each(symbols, fn x ->
        if x.name != "" and x.name != nil do
          lauch_ws(x.name)
        end
      end)
  end

  def list_symbols do
    Repo.all(Symbol)
  end

  @doc """
  Gets a single symbol.

  Raises `Ecto.NoResultsError` if the Symbol does not exist.

  ## Examples

      iex> get_symbol!(123)
      %Symbol{}

      iex> get_symbol!(456)
      ** (Ecto.NoResultsError)

  """
  def get_symbol!(id), do: Repo.get!(Symbol, id)

  @doc """
  Creates a symbol.

  ## Examples

      iex> create_symbol(%{field: value})
      {:ok, %Symbol{}}

      iex> create_symbol(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_symbol(attrs \\ %{}) do
    %Symbol{}
    |> Symbol.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a symbol.

  ## Examples

      iex> update_symbol(symbol, %{field: new_value})
      {:ok, %Symbol{}}

      iex> update_symbol(symbol, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_symbol(%Symbol{} = symbol, attrs) do
    symbol
    |> Symbol.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a symbol.

  ## Examples

      iex> delete_symbol(symbol)
      {:ok, %Symbol{}}

      iex> delete_symbol(symbol)
      {:error, %Ecto.Changeset{}}

  """
  def delete_symbol(%Symbol{} = symbol) do
    Repo.delete(symbol)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking symbol changes.

  ## Examples

      iex> change_symbol(symbol)
      %Ecto.Changeset{data: %Symbol{}}

  """
  def change_symbol(%Symbol{} = symbol, attrs \\ %{}) do
    Symbol.changeset(symbol, attrs)
  end

  def lauch_ws(args) do
    DynamicSupervisor.start_child(FarmGenservers.DynamicSupervisorWs, {FarmGenservers.Workers.WsListener, args} )
  end

  def terminate_subcription(pid) do
    DynamicSupervisor.terminate_child(FarmGenservers.DynamicSupervisorWs, pid)
  end

end
