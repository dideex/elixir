defmodule Backend.TestSupervisor do
  use Supervisor
  alias Backend.Genserver

  # def start_link() do
  #   Supervisor.start_link(__MODULE__, nil, name: __MODULE__)
  # end

  def start_link(_initArgs) do
    Supervisor.start_link(__MODULE__, nil, name: __MODULE__)
  end

  def init(_) do
    children = [
      Genserver
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end
end
