defmodule Daily.Repo.Migrations.CreateGoals do
  use Ecto.Migration

  def change do
    create table(:goals) do
      add :name, :string, null: false
      add :description, :string
      add :period, :string, null: false
      add :streak, :integer, null: false, default: 0
      add :user_id, references(:users, on_delete: :delete_all), null: false

      timestamps()
    end

    create index(:goals, [:user_id])
  end
end
