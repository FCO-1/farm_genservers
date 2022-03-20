defmodule FarmGenservers.PubsubFunctions do

  def broadcast_date_recive(trade, event) do
    Phoenix.PubSub.broadcast!(FarmGenservers.PubSub, "recive", {event, trade})
  end
end
