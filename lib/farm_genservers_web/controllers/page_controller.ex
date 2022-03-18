defmodule FarmGenserversWeb.PageController do
  use FarmGenserversWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
