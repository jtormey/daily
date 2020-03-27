defmodule DailyWeb.GoalController do
  use DailyWeb, :controller

  alias Daily.Goals
  alias Daily.Goals.Goal

  def index(conn, _params) do
    today = Date.utc_today()
    goals = Goals.list_goals(conn.assigns.current_user, with_calendar: today)
    render(conn, "index.html", goals: goals, today: today, page_title: "Goals")
  end

  def new(conn, _params) do
    changeset = Goals.change_goal(%Goal{})
    render(conn, "new.html", changeset: changeset, page_title: "Create Goal")
  end

  def create(conn, %{"goal" => goal_params}) do
    goal_params
    |> Map.put("user_id", conn.assigns.current_user.id)
    |> Goals.create_goal()
    |> case do
      {:ok, goal} ->
        Goals.create_goal_instance(goal, for_date: Date.utc_today())
        conn
        |> put_flash(:info, "Goal created successfully.")
        |> redirect(to: Routes.goal_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset, page_title: "Create Goal")
    end
  end

  def edit(conn, %{"id" => id}) do
    DailyWeb.Email.welcome_email(to: "jrtormey@gmail.com")
    |> Daily.Mailer.deliver_now()
    goal = Goals.get_goal!(id)
    changeset = Goals.change_goal(goal)
    render(conn, "edit.html", goal: goal, changeset: changeset, page_title: "Edit Goal")
  end

  def update(conn, %{"id" => id, "goal" => goal_params}) do
    goal = Goals.get_goal!(id)

    case Goals.update_goal(goal, goal_params) do
      {:ok, _goal} ->
        conn
        |> put_flash(:info, "Goal updated successfully.")
        |> redirect(to: Routes.goal_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", goal: goal, changeset: changeset, page_title: "Edit Goal")
    end
  end

  def delete(conn, %{"id" => id}) do
    goal = Goals.get_goal!(id)
    {:ok, _goal} = Goals.delete_goal(goal)

    conn
    |> put_flash(:info, "Goal deleted successfully.")
    |> redirect(to: Routes.goal_path(conn, :index))
  end
end
