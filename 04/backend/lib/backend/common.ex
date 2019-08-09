defmodule Backend.Common do
  def run do
    Process.spawn(__MODULE__, :worker, [%{count: 0}], [])
  end

  def worker(%{count: count}) do
    receive do
      {from, msg} when is_pid(from) ->
        IO.inspect("Recieved from #{inspect(from)} with message #{inspect(msg)}, count: #{count}")
        send(from, {:answer, msg })
        worker(%{count: count + 1})
      {:set, from, count} when is_pid(from) ->
        IO.inspect("Recieved from #{inspect(from)} setted new count value to #{count}")
        send(from, {:answer, count})
        worker(%{count: count})
      :stop ->
        IO.inspect("Stopped")
    end
  end
end
