defmodule Macroses do
  # {:+, [context: Elixir, import: Kernel], [5, 2]}
  defmacro say({:+, _, [lhs, rhs]}) do
    quote do
      lhs = unquote(lhs)
      rhs = unquote(rhs)
      result = lhs + rhs
      IO.puts("#{lhs} plus #{rhs} is #{result}")
      result
    end
  end

  # {:*, [context: Elixir, import: Kernel], [8, 3]}
  defmacro say({:*, _, [lhs, rhs]}) do
    quote do
      lhs = unquote(lhs)
      rhs = unquote(rhs)
      result = lhs * rhs
      IO.puts("#{lhs} times #{rhs} is #{result}")
      result
    end
  end

  defmacro definfo do
    IO.puts("In macro's context (#{__MODULE__}).")

    quote do
      IO.puts("In caller's context (#{__MODULE__}).")

      def friendly_info do
        IO.puts("""
        My name is #{__MODULE__}
        """)

        # My functions are #{inspect(__info__(:functions))}
      end
    end
  end

  # call = fn -> IO.puts "Calling ..." end
  # log(call.()) won't run twice
  defmacro log(expression) do
    if Application.get_env(:debugger, :log_level) == :debug do
      quote bind_quoted: [expression: expression] do
        IO.puts("=================")
        IO.inspect(expression)
        IO.puts("=================")
        expression
      end
    else
      expression
    end
  end

  # iex> require Macroses
  # iex> Macroses.unless 2 == 5, do: "block entered"
  # "block entered"
  defmacro unless(expression, do: block) do
    quote do
      if !unquote(expression), do: unquote(block)
    end
  end
end

# quote do
#   defmodule My do
#     def hello, do: :world
#   end
# end

# {:defmodule, [context: Elixir, import: Kernel],
#  [
#    {:__aliases__, [alias: false], [:My]},
#    [
#      do: {:def, [context: Elixir, import: Kernel],
#       [{:hello, [context: Elixir], Elixir}, [do: :world]]}
#    ]
#  ]}
