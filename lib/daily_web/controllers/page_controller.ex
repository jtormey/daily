defmodule DailyWeb.PageController do
  use DailyWeb, :controller

  def index(conn, _params) do
    redirect(conn, to: Routes.pow_registration_path(conn, :new))
  end
end
