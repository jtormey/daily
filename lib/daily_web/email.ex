defmodule DailyWeb.Email do
  import Bamboo.Email

  def welcome_email(to: to) do
    base_email(to: to)
    |> subject("Welcome to Daily!")
    |> html_body("<strong>Thanks for joining!</strong>")
    |> text_body("Thanks for joining!")
  end

  def base_email(to: to_email) do
    new_email()
    |> from("hello@usedaily.tech")
    |> to(to_email)
  end
end
