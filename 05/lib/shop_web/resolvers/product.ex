defmodule ShopWeb.Resolvers.Products do
  alias Shop.{Product, Repo, Shop}
  import Ecto.Query, only: [from: 2]

  def get_products(%{user_id: user_id}, _) do
    query =
      from(products in Product,
        join: shops in Shop,
        on: shops.id == products.shop_id,
        where: shops.owner_id == ^user_id
      )

    {:ok, query |> Repo.all()}
  end

  def get_products(_, _) do
    {:ok, Product |> Repo.all()}
  end

  def create_product(%{user_id: user_id, shop_id: shop_id} = data, _) do
    amount = Map.get(data, :amount, 0)
    # shop_query = from(shops in Shop, where: shops.owner_id == ^user_id)
    with %Shop{} <- Shop |> Repo.get_by(owner_id: user_id, id: shop_id) do
      product = %{amount: 0} |> Map.merge(data) |> Map.drop(~w[user_id]a)
      %Product{} |> Product.changeset(product) |> Repo.insert()
    else
      nil -> {:error, "Wrong props"}
      error -> error
    end
  end
end
