defmodule FarmGenservers.Order do
  @moduledoc """
  The Order context.
  """

  import Ecto.Query, warn: false
  alias FarmGenservers.Repo

  alias FarmGenservers.Order.OrderL25

  @doc """
  Returns the list of orders_l25.

  ## Examples

      iex> list_orders_l25()
      [%OrderL25{}, ...]

  """
  def list_orders_l25 do
   query = from l in OrderL25,
   order_by: [desc: l.inserted_at]

   Repo.all(query)
  end

  @doc """
  Gets a single order_l25.

  Raises `Ecto.NoResultsError` if the Order l25 does not exist.

  ## Examples

      iex> get_order_l25!(123)
      %OrderL25{}

      iex> get_order_l25!(456)
      ** (Ecto.NoResultsError)

  """
  def get_order_l25!(id), do: Repo.get!(OrderL25, id)

  @doc """
  Creates a order_l25.

  ## Examples

      iex> create_order_l25(%{field: value})
      {:ok, %OrderL25{}}

      iex> create_order_l25(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_order_l25(attrs \\ %{}) do
    %OrderL25{}
    |> OrderL25.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a order_l25.

  ## Examples

      iex> update_order_l25(order_l25, %{field: new_value})
      {:ok, %OrderL25{}}

      iex> update_order_l25(order_l25, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_order_l25(%OrderL25{} = order_l25, attrs) do
    order_l25
    |> OrderL25.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a order_l25.

  ## Examples

      iex> delete_order_l25(order_l25)
      {:ok, %OrderL25{}}

      iex> delete_order_l25(order_l25)
      {:error, %Ecto.Changeset{}}

  """
  def delete_order_l25(%OrderL25{} = order_l25) do
    Repo.delete(order_l25)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking order_l25 changes.

  ## Examples

      iex> change_order_l25(order_l25)
      %Ecto.Changeset{data: %OrderL25{}}

  """
  def change_order_l25(%OrderL25{} = order_l25, attrs \\ %{}) do
    OrderL25.changeset(order_l25, attrs)
  end


  def tramamiento(list) do
    Enum.map(list, fn x ->

      if is_nil(x["id"]) and is_nil(x["timestamp"]) do
          %{
            order: Decimal.new("0"),
            price: Decimal.new("0"),
            side: "No data",
            size: Decimal.new("0"),
            symbol: "No data"
          }

      else
        %{
          order:  x["id"],
          price: x["price"] |> cast_to_decimal(),
          size: x["size"],
          side: x["side"],
          symbol: x["symbol"]
        }

      end

    end )
  end

  def cast_to_decimal(num) do
    num = to_string(num)
    if num != "" or num != nil do
      Decimal.new(num)
    else
      Decimal.new("0")
    end

  end

  def update_order_s(order_id, _map) do
    query = from o in OrderL25,
    where: o.order == ^order_id
    Repo.all(query)
  end




  def create_multi_orders(list_order) do
    Repo.insert_all(OrderL25, list_order)
  end



  def inserts_orders(list) do
    datos = tramamiento(list)
    create_multi_orders(datos)

  end



end
