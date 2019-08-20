defmodule Shop.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field(:login, :string)
  end

  def changeset(user, attr \\ %{}) do
    user
    |> cast(attr, ~w[login]a)
    |> validate_required(~w[login]a)
  end
end
