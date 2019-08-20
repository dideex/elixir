defmodule Shop.Repo.Migrations.CreateProducts do
  use Ecto.Migration

  def change do
    create table(:products) do
      add(:name, :string)
      add(:price, :integer)
      add(:amount, :integer)
      add(:shop_id, references(:shops))
    end

    create(index(:products, :name))
    create(index(:products, :price))
    create(index(:products, :amount))
    create(index(:products, :shop_id))
  end
end
