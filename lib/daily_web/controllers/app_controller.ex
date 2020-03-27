defmodule DailyWeb.AppController do
  use DailyWeb, :controller

  alias Daily.{Users, Goals}

  def index(conn, _params) do
    user = conn.assigns.current_user
    today = Date.utc_today()

    goals = Goals.list_goal_instances(user, today)

    contacts = user
    |> Users.list_contacts()
    |> Enum.map(fn contact -> {contact, Goals.list_goal_instances(contact, today)} end)

    render(conn, "index.html", goals: goals, contacts: contacts, page_title: "Dashboard")
  end
end
