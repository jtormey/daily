defmodule Daily.UserIdentities.UserIdentity do
  use Ecto.Schema
  use PowAssent.Ecto.UserIdentities.Schema, user: Daily.Users.User

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "user_identities" do
    pow_assent_user_identity_fields()

    timestamps(type: :utc_datetime)
  end
end
