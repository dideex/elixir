defmodule Backend.Avatar do
  use Ecto.Schema
  # require Ecto.Query
  # alias Backend.User

  schema "avatars" do
    field :image_url, :string
    field :nick_name, :string

    belongs_to :user, Backend.User
  end
end
