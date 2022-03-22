defmodule FarmGenservers.Workers.LaunchSymbolsWs do
  use Task

  alias  FarmGenservers.Ctxsymbol
  alias FarmGenservers.Ctxsymbol.Symbol
  defstruct [:ref, :pid]
  require Logger
  #import Poison


    def start_link(_args) do
      Task.start_link(__MODULE__, :run, [])
    end

    def run() do
      Ctxsymbol.launch_symbols()
    end
  end
