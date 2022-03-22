defmodule FarmGenservers.Workers.WsListener do
  use WebSockex

  require Logger
  alias FarmGenservers.PubsubFunctions

  @stream_endpoint "wss://ws.testnet.bitmex.com/realtime?subscribe=orderBookL2_25:"


  def child_spec(symbol) do
    %{
      id: FarmGenservers.Workers.WsListener,
      start: {FarmGenservers.Workers.WsListener, :start_link, [symbol]},
      type: :worker

    }
  end

   def start_link(symbol) do
    symbol = String.upcase(symbol)

    WebSockex.start_link(
      "#{@stream_endpoint}#{symbol}",
      __MODULE__,
      nil
    )
  end

  def handle_frame({_type, msg}, state) do
    case Jason.decode(msg) do
      {:ok, event} -> process_event(event)
      {:error, _} -> Logger.error("Unable to parse msg: #{msg}")
    end

    {:ok, state}
  end

  defp process_event(event) do
    event["data"]

    #IO.inspect(event)

    PubsubFunctions.broadcast_date_recive(event, :data_recive)
  end






end
