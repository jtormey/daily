defmodule Daily.Goals do
  @moduledoc """
  The Goals context.
  """

  import Ecto.Query, warn: false
  alias Daily.Repo

  alias Daily.Goals.{Goal, GoalInstance}
  alias Daily.Users.User

  @doc """
  Returns the list of goals.

  ## Examples

      iex> list_goals()
      [%Goal{}, ...]

  """
  def list_goals do
    Repo.all(Goal)
  end

  def list_goals(%User{id: id}) do
    Repo.all from g in Goal, where: [user_id: ^id]
  end

  def list_goals(%User{id: id}, with_calendar: date) do
    preloader = fn goal_ids ->
      Enum.flat_map goal_ids, fn goal_id ->
        Repo.all from i in GoalInstance,
          join: g in Goal, on: [id: i.goal_id],
          where: g.id == ^goal_id and i.for_date <= ^date,
          order_by: [desc: :for_date],
          limit: 7,
          select: {g.id, i}
      end
    end

    Repo.all from g in Goal,
      where: [user_id: ^id],
      preload: [goal_instances: ^preloader]
  end

  def list_goal_instances(%User{id: id}, date) do
    Repo.all from i in GoalInstance,
      join: g in Goal, on: [id: i.goal_id],
      where: g.user_id == ^id and i.for_date == ^date,
      order_by: [desc: :for_date],
      preload: [goal: g]
  end

  @doc """
  Gets a single goal.

  Raises `Ecto.NoResultsError` if the Goal does not exist.

  ## Examples

      iex> get_goal!(123)
      %Goal{}

      iex> get_goal!(456)
      ** (Ecto.NoResultsError)

  """
  def get_goal!(id), do: Repo.get!(Goal, id)

  def get_goal_instance(id) do
    Repo.get!(GoalInstance, id)
  end

  def get_goal_instance(%Goal{id: id}, for_date: date) do
    Repo.one from i in GoalInstance,
      where: [goal_id: ^id, for_date: ^date]
  end

  @doc """
  Creates a goal.

  ## Examples

      iex> create_goal(%{field: value})
      {:ok, %Goal{}}

      iex> create_goal(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_goal(attrs \\ %{}) do
    %Goal{}
    |> Goal.changeset(attrs)
    |> Repo.insert()
  end

  # TODO: Set up streaming pipeline for this?
  # TODO: Call every day, for next 2 days or so
  def create_goal_instance(for_date: date) do
    Enum.map list_goals(), &create_goal_instance(&1, for_date: date)
  end

  def create_goal_instance(goal = %Goal{}, for_date: date) do
    case get_goal_instance(goal, for_date: date) do
      nil ->
        goal
        |> Ecto.build_assoc(:goal_instances, %{for_date: date})
        |> Repo.insert!()

      goal_instance -> goal_instance
    end
  end

  @doc """
  Updates a goal.

  ## Examples

      iex> update_goal(goal, %{field: new_value})
      {:ok, %Goal{}}

      iex> update_goal(goal, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_goal(%Goal{} = goal, attrs) do
    goal
    |> Goal.changeset(attrs)
    |> Repo.update()
  end

  def update_goal_instance(goal_instance, attrs) do
    goal_instance
    |> GoalInstance.changeset(attrs)
    |> Repo.update()
  end

  # TODO: Prevent completing same goal multiple times
  #         or... increment streaks daily
  def complete_goal_instance(goal_instance) do
    update_goal_instance(goal_instance, %{
      completed: true,
      completed_at: DateTime.utc_now()
    })

    update_goal_query = from g in Goal,
      update: [inc: [streak: 1]],
      where: [id: ^goal_instance.goal_id]

    Repo.update_all(update_goal_query, [])
  end

  @doc """
  Deletes a goal.

  ## Examples

      iex> delete_goal(goal)
      {:ok, %Goal{}}

      iex> delete_goal(goal)
      {:error, %Ecto.Changeset{}}

  """
  def delete_goal(%Goal{} = goal) do
    Repo.delete(goal)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking goal changes.

  ## Examples

      iex> change_goal(goal)
      %Ecto.Changeset{source: %Goal{}}

  """
  def change_goal(%Goal{} = goal) do
    Goal.changeset(goal, %{})
  end
end
