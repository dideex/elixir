defmodule Mix.Tasks.Greeting do
  use Mix.Task

  def run(args) do
    name = args
      |> List.first()
      |> (&(&1 || "user")).()

    :backend
      |> Application.fetch_env!(:greeting)
      |> (&("#{&1}, #{name}!")).()
      |> Mix.Shell.IO.info()
  end
end
# mix greeting String
