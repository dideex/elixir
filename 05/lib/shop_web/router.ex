defmodule ShopWeb.Router do
  use ShopWeb, :router

  scope "/" do
    forward(
      "/user_graphql",
      Absinthe.Plug.GraphiQL,
      schema: ShopWeb.Schema.User,
      socket_url: "http://localhost:4000/user"
    )
  end

  scope "/admin" do
    get(
      "/admin_graphql",
      Absinthe.Plug.GraphiQL,
      schema: ShopWeb.Schema.Admin,
      socket_url: "http://localhost:4000/admin"
    )

    post(
      "/admin_graphql",
      Absinthe.Plug.GraphiQL,
      schema: ShopWeb.Schema.Admin,
      socket_url: "http://localhost:4000/admin"
    )
  end
end
