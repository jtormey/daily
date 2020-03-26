defmodule Daily.Goals.Goal do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "goals" do
    field :description, :string
    field :name, :string
    field :period, :string
    field :streak, :integer, default: 0

    belongs_to :user, Daily.Users.User

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(goal, attrs) do
    goal
    |> cast(attrs, [:name, :description, :period, :streak, :user_id])
    |> validate_required([:name, :period, :streak])
    |> validate_inclusion(:period, ["daily"])
    |> validate_number(:streak, greater_than_or_equal_to: 0)
  end
end
