defmodule DailyWeb.ProfileController do
  use DailyWeb, :controller

  alias Daily.Users.User

  def edit(conn, _params) do
    changeset = User.changeset(conn.assigns.current_user, %{})
    render(conn, "edit.html", changeset: changeset, page_title: "Edit Profile")
  end

  def update(conn, %{"profile" => profile}) do
    conn.assigns.current_user
    |> User.changeset(profile)
    |> Daily.Repo.update()
    |> case do
      {:ok, _user} ->
        conn
        |> put_flash(:info, "Profile updated successfully.")
        |> redirect(to: Routes.profile_path(conn, :edit))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", changeset: changeset, page_title: "Edit Profile")
    end
  end
end
