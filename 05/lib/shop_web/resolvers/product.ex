defmodule ShopWeb.Resolvers.Products do
  alias Shop.{Product, Repo}

  def get_products(_, _) do
    {:ok, Product |> Repo.all()}
  end
end
