defmodule Mix.Tasks.Greeting do
  use Mix.Task
  alias Backend.Greeter, as: Greeter
  alias Mix.Shell.IO

  def run(args) do
    args
      |> List.first()
      |> (&(&1 || "anonymouse")).()
      |> Greeter.greeting()
      |> IO.info()
  end
end
# mix greeting String
