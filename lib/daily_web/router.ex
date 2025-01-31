defmodule DailyWeb.Router do
  use DailyWeb, :router
  use Pow.Phoenix.Router
  use PowAssent.Phoenix.Router
  use Pow.Extension.Phoenix.Router, extensions: [PowInvitation]

  if Mix.env == :dev do
    forward "/sent-emails", Bamboo.SentEmailViewerPlug
  end

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :skip_csrf_protection do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
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
    pipe_through :skip_csrf_protection

    pow_assent_authorization_post_callback_routes()
  end

  scope "/" do
    pipe_through :browser

    pow_routes()
    pow_extension_routes()
    pow_assent_routes()
  end

  scope "/", DailyWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  scope "/", DailyWeb do
    pipe_through [:browser, :protected]

    get "/dashboard", AppController, :index
    resources "/goals", GoalController
    post "/goal-instances/:id/complete", GoalInstanceController, :complete
    resources "/profile", ProfileController, only: [:edit, :update], singleton: true
  end
end
