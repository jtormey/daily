defmodule DailyWeb.GoalInstanceController do
  use DailyWeb, :controller

  alias Daily.Goals

  def complete(conn, %{"id" => goal_instance_id}) do
    goal_instance_id
    |> Goals.get_goal_instance()
    |> Goals.complete_goal_instance()

    redirect(conn, to: Routes.app_path(conn, :index))
  end
end
