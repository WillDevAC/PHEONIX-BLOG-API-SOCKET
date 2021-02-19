defmodule BlogWeb.Plug.SetUser do
  import Plug.Conn

  alias Blog.Accounts

  def init(_), do: nil

  def call(conn, _) do
    user_id = get_session(conn, :user_id)

    user = user_id && Accounts.get_user!(user_id)

    if user != nil do
      assign(conn, :user, user)
    else
      assign(conn, :user, nil)
    end
  end
end
