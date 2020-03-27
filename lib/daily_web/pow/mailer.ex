defmodule DailyWeb.Pow.Mailer do
  use Pow.Phoenix.Mailer

  import Bamboo.Email

  require Logger

  alias DailyWeb.Email

  def cast(%{user: user, subject: subject, text: text, html: html, assigns: _assigns}) do
    %{to: user.email, subject: subject, text: text, html: html}
  end

  def process(email) do
    Email.base_email(to: email.to)
    |> subject(email.subject)
    |> html_body(email.html)
    |> text_body(email.text)
    |> Daily.Mailer.deliver_now()

    Logger.info("Processed and sent email: #{inspect email}")
  end
end
