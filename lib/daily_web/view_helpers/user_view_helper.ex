defmodule DailyWeb.UserViewHelper do
  alias Daily.Users.User

  def first_name(%User{first_name: first_name}) when is_binary(first_name), do: first_name
  def first_name(%User{email: email}), do: name_for_email(email)

  def full_name(%User{first_name: f, last_name: l}) when is_binary(f) and is_binary(l), do: f <> " " <> l
  def full_name(%User{first_name: first_name}) when is_binary(first_name), do: first_name
  def full_name(%User{email: email}), do: name_for_email(email)

  def initials(%User{first_name: f, last_name: l}) when is_binary(f) and is_binary(l), do: String.first(f) <> String.first(l)
  def initials(%User{first_name: first_name}) when is_binary(first_name), do: String.slice(first_name, 0..1)
  def initials(%User{email: email}), do: String.slice(email, 0..1) |> String.upcase()

  def name_for_email(email), do: String.split(email, ~r/@/) |> Enum.at(0, "") |> String.capitalize()
end
