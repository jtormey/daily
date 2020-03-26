defmodule DailyWeb.Pow.Plug.SessionToken do
  use Pow.Plug.Base

  alias Daily.{Repo, Users}

  @session_key :pow_user_token

  def fetch(conn, _config) do
    conn = Plug.Conn.fetch_session(conn)
    token = Plug.Conn.get_session(conn, @session_key)

    DailyWeb.Endpoint
    |> Phoenix.Token.verify(get_env(:signing_salt), token, max_age: get_env(:max_age))
    |> maybe_load_user(conn)
  end

  defp maybe_load_user({:ok, user_id}, conn), do: {conn, Repo.get(Users.User, user_id)}
  defp maybe_load_user({:error, _any}, conn), do: {conn, nil}

  def create(conn, user, _config) do
    token = Phoenix.Token.sign(DailyWeb.Endpoint, get_env(:signing_salt), user.id)

    conn = conn
    |> Plug.Conn.fetch_session()
    |> Plug.Conn.put_session(@session_key, token)

    {conn, user}
  end

  def delete(conn, _config) do
    conn
    |> Plug.Conn.fetch_session()
    |> Plug.Conn.delete_session(@session_key)
  end

  def get_env(key) do
    Application.get_env(:daily, __MODULE__)[key]
  end
end
