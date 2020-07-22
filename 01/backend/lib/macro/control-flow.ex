defmodule ControlFlow do
  defmacro my_if(expr, do: if_block), do: if(expr, do: if_block, else: nil)
  defmacro my_if(expr, do: do_block, else: else_block) do
    quote do
      case unquote(expr) do
        res when res in [false, nil] -> unquote(else_block)
        _ -> unquote(do_block)
      end
    end
  end
end
