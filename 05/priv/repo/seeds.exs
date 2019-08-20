# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Shop.Repo.insert!(%Shop.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fa il if something goes wrong.
{:ok, seller} =
  %Shop.User{}
  |> Shop.User.changeset(%{login: "Seller #1"})
  |> Shop.Repo.insert()

{:ok, _} =
  %Shop.User{}
  |> Shop.User.changeset(%{login: "Buyer #1"})
  |> Shop.Repo.insert()

{:ok, shop} =
  %Shop.Shop{}
  |> Shop.Shop.changeset(%{name: "Shop #1", owner_id: seller.id})
  |> Shop.Repo.insert()

products = [
  %{name: "Mouse", price: 500, amount: 100, shop_id: shop.id},
  %{name: "Keyboard", price: 3999, amount: 19, shop_id: shop.id}
]

products
|> Enum.each(fn product ->
  {:ok, _} =
    %Shop.Product{}
    |> Shop.Product.changeset(product)
    |> Shop.Repo.insert()
end)
