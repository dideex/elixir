defmodule Macro.Impl do
  import Loop

  def run_while do
    pid = spawn(fn -> :timer.sleep(4000) end)

    while Process.alive?(pid) do
      IO.puts("#{inspect(:erlang.time())} iterating throw while loop")
      :timer.sleep(1000)
    end
  end
end
