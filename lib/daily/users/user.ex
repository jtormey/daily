defmodule Daily.Users.User do
  use Ecto.Schema
  use Pow.Ecto.Schema
  use PowAssent.Ecto.Schema
  use Pow.Extension.Ecto.Schema, extensions: [PowInvitation]

  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "users" do
    pow_user_fields()

    field :first_name, :string
    field :last_name, :string

    has_many :goals, Daily.Goals.Goal

    many_to_many :contacts, Daily.Users.User,
      join_through: Daily.Users.UserContact,
      join_keys: [user_id: :id, contact_id: :id]

    many_to_many :invited_by_contacts, Daily.Users.User,
      join_through: Daily.Users.UserContact,
      join_keys: [contact_id: :id, user_id: :id]

    timestamps(type: :utc_datetime)
  end

  def changeset(user_or_changeset, attrs) do
    user_or_changeset
    |> pow_changeset(attrs)
    |> pow_extension_changeset(attrs)
    |> cast(attrs, [:first_name, :last_name])
    |> validate_required([:first_name, :last_name])
  end

  def profile_changeset(user_or_changeset, attrs) do
    user_or_changeset
    |> cast(attrs, [:email, :first_name, :last_name])
    |> validate_required([:email, :first_name, :last_name])
  end

  def user_identity_changeset(user_or_changeset, user_identity, attrs, user_id_attrs) do
    user_or_changeset
    |> pow_assent_user_identity_changeset(user_identity, attrs, user_id_attrs)
    |> cast(transform_attrs(attrs), [:first_name, :last_name])
  end

  def invite_changeset(user_or_changeset, invited_by, attrs) do
    user_or_changeset
    |> pow_invite_changeset(invited_by, attrs)
    |> put_assoc(:invited_by_contacts, [invited_by])
  end

  def transform_attrs(attrs) do
    %{first_name: attrs["given_name"], last_name: attrs["family_name"]}
  end
end
