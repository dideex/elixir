defmodule ShopWeb.AdminSocket do
  use Phoenix.Socket
  use Absinthe.Phoenix.Socket, schema: ShopWeb.Schema.Admin

  def connect(_params, socket, _connect_info) do
    {:ok, socket}
  end

  def id(_socket), do: nil
end
