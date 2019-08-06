defmodule BackendWeb.PageController do
  use BackendWeb, :controller

  def index(connection, _params) do
    render(connection, "index.html")
  end

  def about(connection, _params) do
    # IO.inspect(connection)
    render(connection, "about.html")
  end

  @data %{
    "alexey" => %{name: 'Alexey'},
    "ivan" => %{name: 'Ivan'}
  }

  def login(connection, %{"user_id" => user_id}) do
    IO.inspect(user_id)
    user = Map.get(@data, user_id, %{name: "Guest"})
    render(connection, "login.html", user: user)
  end
end
