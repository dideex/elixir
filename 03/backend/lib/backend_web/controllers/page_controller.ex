defmodule BackendWeb.PageController do
  use BackendWeb, :controller

  def index(connection, _params) do
    render(connection, "index.html")
  end

  def about(connection, _params) do
    render(connection, "about.html")
  end
end
