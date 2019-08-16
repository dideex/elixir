defmodule Shop.Repo.Migrations.CreateProducts do
  use Ecto.Migration

  def change do
    create table(:products) do
      add(:name, :string)
      add(:price, :integer)
      add(:amount, :integer)
    end

    create(index(:products, :name))
    create(index(:products, :price))
    create(index(:products, :amount))
  end
end
