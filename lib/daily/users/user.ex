defmodule Daily.Users.User do
  use Ecto.Schema
  use Pow.Ecto.Schema

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "users" do
    pow_user_fields()

    timestamps(type: :utc_datetime)
  end
end
