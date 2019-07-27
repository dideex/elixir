defmodule Backend.Repo.Migrations.CreateAvatarTable do
  use Ecto.Migration

  def change do
    create table(:avatars) do
      add :image_url, :string
      add :nick_name, :string
      add :user_id, references(:users)
    end
  end
end
