defmodule ShopWeb.Router do
  use ShopWeb, :router

  scope "/" do
    forward(
      "/graphql",
      Absinthe.Plug.GraphiQL,
      schema: ShopWeb.Schema
    )
  end
end
