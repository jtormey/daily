defmodule Daily.GoalsTest do
  use Daily.DataCase

  alias Daily.Goals

  describe "goals" do
    alias Daily.Goals.Goal

    @valid_attrs %{description: "some description", name: "some name", period: "some period", streak: 42}
    @update_attrs %{description: "some updated description", name: "some updated name", period: "some updated period", streak: 43}
    @invalid_attrs %{description: nil, name: nil, period: nil, streak: nil}

    def goal_fixture(attrs \\ %{}) do
      {:ok, goal} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Goals.create_goal()

      goal
    end

    test "list_goals/0 returns all goals" do
      goal = goal_fixture()
      assert Goals.list_goals() == [goal]
    end

    test "get_goal!/1 returns the goal with given id" do
      goal = goal_fixture()
      assert Goals.get_goal!(goal.id) == goal
    end

    test "create_goal/1 with valid data creates a goal" do
      assert {:ok, %Goal{} = goal} = Goals.create_goal(@valid_attrs)
      assert goal.description == "some description"
      assert goal.name == "some name"
      assert goal.period == "some period"
      assert goal.streak == 42
    end

    test "create_goal/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Goals.create_goal(@invalid_attrs)
    end

    test "update_goal/2 with valid data updates the goal" do
      goal = goal_fixture()
      assert {:ok, %Goal{} = goal} = Goals.update_goal(goal, @update_attrs)
      assert goal.description == "some updated description"
      assert goal.name == "some updated name"
      assert goal.period == "some updated period"
      assert goal.streak == 43
    end

    test "update_goal/2 with invalid data returns error changeset" do
      goal = goal_fixture()
      assert {:error, %Ecto.Changeset{}} = Goals.update_goal(goal, @invalid_attrs)
      assert goal == Goals.get_goal!(goal.id)
    end

    test "delete_goal/1 deletes the goal" do
      goal = goal_fixture()
      assert {:ok, %Goal{}} = Goals.delete_goal(goal)
      assert_raise Ecto.NoResultsError, fn -> Goals.get_goal!(goal.id) end
    end

    test "change_goal/1 returns a goal changeset" do
      goal = goal_fixture()
      assert %Ecto.Changeset{} = Goals.change_goal(goal)
    end
  end
end
