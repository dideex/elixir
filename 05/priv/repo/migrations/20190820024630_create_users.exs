defmodule Shop.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add(:login, :string)
      add(:password, :integer)
    end

    create(index(:users, :login))
  end
end
