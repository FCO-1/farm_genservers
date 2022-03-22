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
      IO.inspect(event, label: "mensaje desde trader")
      unless is_nil(datos) do
        if Map.has_key?(event, "action") do
          if event["action"] == "insert" do
            Order.inserts_orders(datos)
          end
        end

      end

      {:noreply, state}
    end






end
