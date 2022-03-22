defmodule FarmGenservers.Workers.LaunchSymbolsWs do
  use Task

  alias  FarmGenservers.Ctxsymbol
  alias FarmGenservers.Ctxsymbol.Symbol
  defstruct [:ref, :pid]
  require Logger
  #import Poison


    def start_link(_args) do
      Task.start_link(__MODULE__, :run, [_args])
    end

    def run(_arg) do
      Ctxsymbol.test()
    end
  end
