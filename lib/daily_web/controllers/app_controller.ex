defmodule DailyWeb.AppController do
  use DailyWeb, :controller

  alias Daily.Goals

  def index(conn, _params) do
    goals = Goals.list_goal_instances(conn.assigns.current_user, Date.utc_today())
    render(conn, "index.html", goals: goals, page_title: "Dashboard")
  end
end
