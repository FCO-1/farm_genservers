defmodule FarmGenserversWeb.Router do
  use FarmGenserversWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {FarmGenserversWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", FarmGenserversWeb do
    pipe_through :browser

    get "/", PageController, :index

    live "/orders_l25", OrderL25Live.Index, :index
    live "/orders_l25/new", OrderL25Live.Index, :new
    live "/orders_l25/:id/edit", OrderL25Live.Index, :edit

    live "/orders_l25/:id", OrderL25Live.Show, :show
    live "/orders_l25/:id/show/edit", OrderL25Live.Show, :edit


    live "/symbols", SymbolLive.Index, :index
    live "/symbols/new", SymbolLive.Index, :new
    live "/symbols/:id/edit", SymbolLive.Index, :edit

    live "/symbols/:id", SymbolLive.Show, :show
    live "/symbols/:id/show/edit", SymbolLive.Show, :edit
  end

  # Other scopes may use custom stacks.
  # scope "/api", FarmGenserversWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: FarmGenserversWeb.Telemetry
    end
  end
end
