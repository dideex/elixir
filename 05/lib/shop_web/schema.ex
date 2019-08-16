defmodule ShopWeb.Schema do
  use Absinthe.Schema

  query do
    field :test, :string do
      arg(:name, non_null(:string))

      resolve(fn %{name: name}, _ ->
        {:ok, "#{name} reply"}
      end)
    end
  end

end
