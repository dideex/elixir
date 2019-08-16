defmodule Shop.Product do
  use Ecto.Schema
  import Ecto.Changeset

  schema "products" do
    field(:name, :string)
    field(:price, :integer)
    field(:amount, :integer)
  end

  def changeset(product, attr \\ %{}) do
    product
    |> cast(attr, ~w[name price amount]a)
  end
end
