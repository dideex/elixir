defmodule Mix.Tasks.Greeting do
  use Mix.Task
  use Backend.Greeter
  alias Backend.Greeter, as: Greeter
  alias Mix.Shell.IO
  # require Backend.Greeter
  import Backend.Greeter, only: [concat: 1]

  def run(args) do
    greeting = args
      |> List.first()
      |> (&(&1 || "anonymouse")).()
      |> Greeter.greeting()

    greeting + good_wish()
      |> concat()
      |> IO.info()
  end
end
# mix greeting String
