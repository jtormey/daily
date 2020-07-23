defmodule Daily.GoalClock do
  use GenServer

  require Logger

  alias Daily.Goals

  @days_out 3
  @clock_interval 3_600_000

  def start_link(_opts \\ []) do
    GenServer.start_link(__MODULE__, nil)
  end

  @impl true
  def init(nil) do
    :timer.send_interval(@clock_interval, :tick)
    Logger.info("Goal clock started, generating goal instances every #{@clock_interval / 1000}s")
    {:ok, nil}
  end

  @impl true
  def handle_info(:tick, state) do
    Logger.info("Generating new goal instances at a max of #{@days_out} days out...")
    goal_instances = Goals.create_goal_instances_spanning(days: @days_out)
    Logger.info("Generated or checked #{length goal_instances} goal instances successfully")
    {:noreply, state}
  end
end
