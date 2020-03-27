defmodule DailyWeb.UserViewHelper do
  alias Daily.Users.User

  def full_name(%User{first_name: f, last_name: l}), do: f <> " " <> l
  def full_name(%User{first_name: first_name}), do: first_name
  def full_name(_otherwise), do: nil

  def initials(%User{first_name: f, last_name: l}), do: String.first(f) <> String.first(l)
  def initials(%User{first_name: first_name}), do: String.slice(first_name, 0..1)
  def initials(%User{email: email}), do: String.slice(email, 0..1)
end
