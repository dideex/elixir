defmodule Backend.Greeter do
  @moduledoc """
  Just greeting
  @param: name<String>
  """
  @greeting Application.fetch_env!(:backend, :greeting)

  defmacro __using__(_) do
    quote do
      def good_wish, do: "Have a nice day!"
    end
  end

  defmacro concat({:+, _, [lhs, rhs]}) do
    quote do
      "#{unquote(lhs)} <> #{unquote(rhs)}"
    end
  end

  def greeting(name) do
    @greeting <> ", #{name}"
  end
end
