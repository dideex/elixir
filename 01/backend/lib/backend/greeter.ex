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

  defguard is_even(value) when is_integer(value) and rem(value, 2) === 0

  def inc_even_num(v) when is_even(v) do
    v + 1
  end

  def greeting(name \\ "anonymouse") do
    @greeting <> ", #{sanitize_name(name)}!"
  end

  def greeting_many(names) do
    names
      |> senitize_names()
      |> Enum.map(&greeting/1)
      |> Enum.join(" ")
  end

  defp sanitize_name(name) do
    name
      |> String.trim()
      |> String.capitalize()
  end
  # sum = &Backend.Greeter.greeting/1
  # sum.("People")

  defp senitize_names(names) do
    names
      |> Enum.reduce([], fn
          name, acc when is_bitstring(name) -> [name | acc]
          _, acc -> acc
        end)
      |> Enum.reverse()
  end
end
