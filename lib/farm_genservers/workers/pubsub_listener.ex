defmodule FarmGenservers.Workers.PubsubListener do
  use GenServer

  alias  FarmGenservers.Order

  defstruct [:ref, :pid]
  require Logger
  #import Poison

    def start_link(_) do
      GenServer.start_link(__MODULE__, nil, name: __MODULE__)
    end

    def init(_) do
      Phoenix.PubSub.subscribe(FarmGenservers.PubSub, "recive")
      {:ok, %{}}
    end


    def handle_info({:data_recive, event}, state) do
      datos = event["data"]
      unless is_nil(datos) do
        if Map.has_key?(event, "action") do
          action = event["action"]
          cond  do
          action == "insert" ->  Order.inserts_orders(datos)
          action == "delete" -> Order.delete_multi_orders(datos)
          true -> Logger.info("No hay accion")

          end
        end

      end

      {:noreply, state}
    end






end
