defmodule DailyWeb.Router do
  use DailyWeb, :router
  use Pow.Phoenix.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :protected do
    plug Pow.Plug.RequireAuthenticated,
      error_handler: Pow.Phoenix.PlugErrorHandler
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/" do
    pipe_through :browser

    pow_routes()
  end

  scope "/", DailyWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  scope "/", DailyWeb do
    pipe_through [:browser, :protected]

    get "/me", AppController, :index
  end
end
