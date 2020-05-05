defmodule RumblWeb.SessionController do 
  use RumblWeb, :controller
  alias Rumbl.Accounts

  def new(conn, _) do
    render(conn, "new.html")
  end

  def create(conn, %{"session" => %{"username" => username, "password" => pass}}) do
    IO.puts "-------username-- #{username} #{pass}"
   case Accounts.authenticate_by_username_and_pass(username, pass) do
    {:ok, user} ->
      conn
      |> RumblWeb.Auth.login(user)
      |> put_flash(:info, "#{user.name} created!")
      |> redirect(to: Routes.user_path(conn, :index))
    {:error, _reason} ->
      conn
      |> put_flash(:error, "Invalid username/password combination")
      |> render("new.html")
   end
  end

  def delete(conn, _) do
    conn
    |> RumblWeb.Auth.logout()
    |> redirect(to: Routes.page_path(conn, :index))
  end
end