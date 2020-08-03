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

defmodule I18n do
  use Translator

  locale("en",
    flash: [hello: "Hello %{first} %{last}!", bye: "Bye, %{name}!"],
    users: [
      title: "Users"
    ]
  )

  locale("fr",
    flash: [hello: "Salut %{first} %{last}!", bye: "Au revoir, %{name}!"],
    users: [
      title: "Utilisateurs"
    ]
  )
end
