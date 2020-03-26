defmodule DailyWeb.Pow.Routes do
  use Pow.Phoenix.Routes

  alias DailyWeb.Router.Helpers, as: Routes

  def after_sign_in_path(conn), do: Routes.app_path(conn, :index)
end
