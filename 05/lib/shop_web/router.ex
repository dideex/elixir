defmodule ShopWeb.Router do
  use ShopWeb, :router

  scope "/user" do
    forward(
      "/graphql",
      Absinthe.Plug.GraphiQL,
      schema: ShopWeb.Schema.User,
      socket_url: "http://localhost:4000/user"
    )
  end

  scope "/admin" do
    get(
      "/graphql",
      Absinthe.Plug.GraphiQL,
      schema: ShopWeb.Schema.Admin,
      socket_url: "http://localhost:4000/admin"
    )

    post(
      "/graphql",
      Absinthe.Plug.GraphiQL,
      schema: ShopWeb.Schema.Admin,
      socket_url: "http://localhost:4000/admin"
    )
  end
end
