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

  def greeting(name \\ "anonymouse") do
    @greeting <> ", #{sanitize_name(name)}"
  end

  defp sanitize_name(name) do
    name
      |> String.trim()
      |> String.capitalize()
  end
  # sum = &Backend.Greeter.greeting/1
  # sum.("People")

  def senitize_names(names) do
    names
      |> Enum.reduce([], fn
          name, acc when is_bitstring(name) -> [name | acc]
          _, acc  -> acc
        end)
      |> Enum.reverse()
  end
end
