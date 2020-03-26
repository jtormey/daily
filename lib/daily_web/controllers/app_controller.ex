defmodule DailyWeb.AppController do
  use DailyWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html", page_title: "Dashboard")
  end
end
