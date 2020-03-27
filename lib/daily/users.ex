defmodule Daily.Users do
  import Ecto.Query, warn: false

  alias Daily.Repo
  alias Daily.Users.{User, UserContact}

  def list_contacts(%User{id: id}) do
    Repo.all from c in User,
      join: uc in UserContact, on: [contact_id: c.id],
      join: u in User, on: [id: uc.user_id],
      where: u.id == ^id
  end
end
