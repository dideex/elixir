defmodule Shop.Product do
  use Ecto.Schema
  alias Shop.Shop
  import Ecto.Changeset

  schema "products" do
    field(:name, :string)
    field(:price, :integer)
    field(:amount, :integer)

    belongs_to(:shop, Shop)
  end

  def changeset(product, attr \\ %{}) do
    product
    |> cast(attr, ~w[name price amount shop_id]a)
    |> assoc_constraint(:shop)
  end
end
