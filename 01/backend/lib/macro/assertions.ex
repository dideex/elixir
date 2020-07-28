defmodule Assertion do
  defmacro __using__(_opts) do
    quote do
      import unquote(__MODULE__)
      Module.register_attribute(__MODULE__, :tests, accumulate: true)
      @before_compile unquote(__MODULE__)
    end
  end

  defmacro __before_compile__(_env) do
    quote do
      def run do
        IO.puts("Running the tests... #{inspect @tests}")
      end
    end
  end

  defmacro assert({operator, _, [lhs, rhs]}) do
    quote bind_quoted: [operator: operator, lhs: lhs, rhs: rhs] do
      Assertion.Test.assert(operator, lhs, rhs)
    end
  end

  defmacro test(description, do: test_block) do
    test_func = String.to_atom(description)

    quote do
      @tests {unquote(test_func), unquote(description)}
      def unquote(test_func)(), do: unquote(test_block)
    end
  end
end

defmodule Assertion.Test do
  def assert(:==, lhs, rhs) when lhs == rhs do
    IO.write(".")
  end

  def assert(:==, lhs, rhs) do
    IO.puts("""
    FAILURE:
    Expected:    #{lhs}
    to be equal: #{rhs}
    """)
  end

  def assert(:>, lhs, rhs) when lhs > rhs do
    IO.write(".")
  end

  def assert(:>, lhs, rhs) do
    IO.puts("""
    FAILURE:
      Expected: #{lhs}
      to be greater than: #{rhs}
    """)
  end

  def assert(:<, lhs, rhs) when lhs < rhs do
    IO.write(".")
  end

  def assert(:<, lhs, rhs) do
    IO.puts("""
    FAILURE:
      Expected: #{lhs}
      to be less than: #{rhs}
    """)
  end
end
