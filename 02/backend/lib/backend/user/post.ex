defmodule Backend.User.Post do
  use Ecto.Schema
  alias Backend.{Repo, User}

  schema "posts" do
    field :text, :string

    belongs_to :user, Backend.User
    many_to_many :tags, Backend.User.Tag, join_through: "posts_tags"
  end

  def new_post(user_id, text) do
    %User{id: user_id}
      |> Ecto.build_assoc(:posts, %{text: text})
      |> Repo.insert()
  end
end
