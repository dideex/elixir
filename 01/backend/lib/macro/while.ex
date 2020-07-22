defmodule Loop do
  defmacro while(expr, do: do_block) do
    quote do
      try do
        for _ <- Stream.cycle([:ok]) do
          if unquote(expr) do
            unquote(do_block)
          else
            IO.inspect "look is breaked"
            throw :break
          end
        end
        catch
          :break -> :ok
      end
    end
  end
end
