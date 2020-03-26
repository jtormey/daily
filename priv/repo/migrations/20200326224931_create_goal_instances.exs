defmodule Daily.Repo.Migrations.CreateGoalInstances do
  use Ecto.Migration

  def change do
    create table(:goal_instances) do
      add :for_date, :date, null: false
      add :completed, :boolean, default: false, null: false
      add :completed_at, :utc_datetime
      add :goal_id, references(:goals, on_delete: :delete_all), null: false

      timestamps()
    end

    create index(:goal_instances, [:goal_id])
  end
end
