defmodule Daily.Goals.GoalInstance do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "goal_instances" do
    field :completed, :boolean, default: false
    field :completed_at, :utc_datetime
    field :for_date, :date
    field :goal_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(goal_instance, attrs) do
    goal_instance
    |> cast(attrs, [:for_date, :completed, :completed_at])
    |> validate_required([:for_date, :completed, :completed_at])
  end
end
