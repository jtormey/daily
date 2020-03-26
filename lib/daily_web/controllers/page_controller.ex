defmodule DailyWeb.PageController do
  use DailyWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
