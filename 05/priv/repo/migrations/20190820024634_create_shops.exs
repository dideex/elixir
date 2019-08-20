defmodule Shop.Repo.Migrations.CreateShops do
  use Ecto.Migration

  def change do
    create table(:shops) do
      add(:name, :string)
      add(:address, :integer)
      add(:owner_id, references(:users))
    end

    create(index(:shops, :name))
    create(index(:shops, :address))
  end
end
