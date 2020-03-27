defmodule Daily.Repo.Migrations.CreateUserContacts do
  use Ecto.Migration

  def change do
    create table(:user_contacts, primary_key: false) do
      add :invite_accepted, :boolean, default: false, null: false
      add :invite_accepted_at, :utc_datetime
      add :user_id, references(:users, on_delete: :delete_all), primary_key: true
      add :contact_id, references(:users, on_delete: :delete_all), primary_key: true

      timestamps()
    end

    create index(:user_contacts, [:user_id])
    create index(:user_contacts, [:contact_id])
  end
end
