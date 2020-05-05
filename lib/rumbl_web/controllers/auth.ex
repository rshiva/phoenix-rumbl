defmodule RumblWeb.Auth do
  import Plug.Conn

  #compile time
  def init(opts) do
    opts
  end

  #runtime
  def call(conn, _opts) do
    user_id = get_session(conn, :user_id)
    user = user_id && Rumbl.Accounts.get_user(user_id)
    assign(conn, :current_user, user)
  end
end