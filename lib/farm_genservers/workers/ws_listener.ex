defmodule FarmGenservers.Workers.WsListener do
  use WebSockex

  require Logger
  alias FarmGenservers.PubsubFunctions

  @stream_endpoint "wss://ws.testnet.bitmex.com/realtime?subscribe=orderBookL2_25:"


  def child_spec(symbol) do
    name = String.downcase(symbol)
    atom = String.to_atom("ws#{name}")
    %{
      id: atom,
      start: {FarmGenservers.Workers.WsListener, :start_link, [symbol]},
      type: :worker

    }
  end


   def start_link(symbol) do
    symbol = String.upcase(symbol)
    name = String.downcase(symbol)
    atom = String.to_atom("pid#{name}")



   pid = spawn( fn -> WebSockex.start_link(
      "#{@stream_endpoint}#{symbol}",
      __MODULE__,
      self()
      )
   end )
   Process.register(pid, atom)
   process = Process.info(pid)
   IO.inspect(process, label: "pid register")
  end

  def handle_frame({_type, msg}, state) do
    case Jason.decode(msg) do
      {:ok, event} -> process_event(event)
      {:error, _} -> Logger.error("Unable to parse msg: #{msg}")
    end
    IO.inspect(state)
    {:ok, state}
  end

  defp process_event(event) do
    event["data"]

    #IO.inspect(event)

    PubsubFunctions.broadcast_date_recive(event, :data_recive)
  end


  def terminate(reason, state) do
    IO.puts("Socket Terminating:\n#{inspect reason}\n\n#{inspect state}\n")
    exit(:normal)
end





end
