defmodule FarmGenservers.PubsubListener do
  use GenServer



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
      IO.inspect(datos, label: "mensaje desde trader")


      {:noreply, state}
    end





end
