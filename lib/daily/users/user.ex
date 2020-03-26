defmodule Daily.Users.User do
  use Ecto.Schema
  use Pow.Ecto.Schema
  use PowAssent.Ecto.Schema

  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "users" do
    pow_user_fields()

    field :first_name, :string
    field :last_name, :string

    timestamps(type: :utc_datetime)
  end

  def changeset(user_or_changeset, attrs) do
    user_or_changeset
    |> pow_changeset(attrs)
    |> cast(attrs, [:first_name, :last_name])
    |> validate_required([:first_name, :last_name])
  end

  def user_identity_changeset(user_or_changeset, user_identity, attrs, user_id_attrs) do
    user_or_changeset
    |> pow_assent_user_identity_changeset(user_identity, attrs, user_id_attrs)
    |> cast(transform_attrs(attrs), [:first_name, :last_name])
  end

  def transform_attrs(attrs) do
    %{first_name: attrs["given_name"], last_name: attrs["family_name"]}
  end
end
