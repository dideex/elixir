defmodule Backend.User do
  use Ecto.Schema
  require Ecto.Query
  alias Ecto.Changeset

  schema "users" do
    field :email, :string
    field :name, :string
    field :password, :string
    field :age, :integer

    has_one :avatar, Backend.User.Avatar
    has_many :posts, Backend.User.Post
  end

  def changeset(user, params \\ %{}) do
    user
      |> Changeset.cast(params, [:email, :name, :password, :age])
      |> Changeset.validate_required([:name, :password])
      |> Changeset.validate_length(:name, min: 3)
  end

  def get_first_record do
    Backend.Repo.one(Ecto.Query.from u in __MODULE__, order_by: [asc: u.id], limit: 1)
  end

  def get_last_record do
    __MODULE__
      |> Ecto.Query.last()
      |> Backend.Repo.one()
  end

end
