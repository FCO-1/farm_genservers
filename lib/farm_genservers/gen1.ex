defmodule FarmGenservers.Gen1 do
  use WebSockex

  require Logger

  @stream_endpoint "wss://ws.testnet.bitmex.com/realtime?subscribe=orderBookL2_25:XBTUSD"
  @moduledoc """
  Documentation for `StreamerEx`.
  """

   def start_link(_symbol) do
    #symbol = String.downcase(_symbol)

    WebSockex.start_link(
      @stream_endpoint,
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
    IO.inspect(event)
  end






end
