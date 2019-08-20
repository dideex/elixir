defmodule Shop.Shop do
  use Ecto.Schema
  import Ecto.Changeset
  alias Shop.{User, Product}

  schema "shops" do
    field(:name, :string)
    field(:address, :string)

    belongs_to(:owner, User)
    has_many(:products, Product)
  end

  def changeset(shop, attr \\ %{}) do
    shop
    |> cast(attr, ~w[name address owner_id]a)
    |> validate_required(~w[name]a)
    |> assoc_constraint(:owner)
  end
end
