defmodule Daily.Users.UserContact do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  @foreign_key_type :binary_id

  schema "user_contacts" do
    field :invite_accepted, :boolean, default: false
    field :invite_accepted_at, :utc_datetime

    belongs_to :user, Daily.Users.User
    belongs_to :contact, Daily.Users.User

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(user_contact, attrs) do
    user_contact
    |> cast(attrs, [:invite_accepted, :invite_accepted_at])
    |> validate_required([:invite_accepted, :invite_accepted_at])
  end
end
