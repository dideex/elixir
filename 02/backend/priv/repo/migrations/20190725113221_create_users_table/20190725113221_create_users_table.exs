defmodule :"Elixir.Backend.Repo.Migrations.CreateUsersTable.exs" do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string
      add :email, :string
      add :password, :string
      add :age, :integer
    end
  end
end
