defmodule DailyWeb.GoalView do
  use DailyWeb, :view

  alias Daily.Goals.Goal

  def goal_completed_today?(goal = %Goal{}) do
    goal.goal_instances
    |> Enum.at(0, %{})
    |> Map.get(:completed, false)
  end

  def assemble_calendar(goal = %Goal{}, for_date: date) do
    goal.goal_instances
    |> fill_to_length(length: 7)
    |> Enum.zip(week_span(for_date: date))
    |> Enum.reduce([], fn
      {nil, for_date}, acc -> [{false, day_of_week_letter(for_date)} | acc]
      {i, _}, acc -> [{i.completed, day_of_week_letter(i.for_date)} | acc]
    end)
  end

  def day_of_week_letter(date) do
    case Date.day_of_week(date) do
      1 -> "M"
      2 -> "T"
      3 -> "W"
      4 -> "R"
      5 -> "F"
      _ -> "S"
    end
  end

  def week_span(for_date: date) do
    Enum.map 0..6, fn i -> Date.add(date, -i) end
  end

  def fill_to_length(xs, length: l) do
    xs = Enum.take(xs, l)
    xs ++ Enum.map(Enum.drop(0..(l - length(xs)), 1), fn _ -> nil end)
  end
end
