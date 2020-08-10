ExUnit.start()
Code.require_file("while.ex", __DIR__)

defmodule WhileTest do
  use ExUnit.Case
  import Loop

  test "Is it really that ease?" do
    assert Code.ensure_loaded?(Loop)
  end

  test "while loops as long as the expression is thruthy" do
    pid = spawn(fn -> :timer.sleep(:infinity) end)

    send self, :one
    while Process.alive?(pid) do
      receive do
        :one -> send self, :two
        :two -> send self, :three
        :three ->
            Process.exit(pid, :kill)
            send self, :done
      end
    end
    assert_received :done
  end
end
