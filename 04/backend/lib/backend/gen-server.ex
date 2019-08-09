defmodule Backend.Genserver do
  use GenServer, restart: :transient

  def start_link(_args) do
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end

  def start do
    GenServer.start(__MODULE__, nil, name: __MODULE__)
  end

  def getCount do
    GenServer.call(__MODULE__, :count)
  end

  def getCount(pid) do
    GenServer.call(pid, :count)
  end

  def stop do
    GenServer.cast(__MODULE__, :stop)
  end

  def stop(pid) do
    GenServer.cast(pid, :stop)
  end

  def init(args) do
    {:ok, %{count: 0, args: args}}
  end

  def handle_info(msg, %{count: count} = state) do
    IO.inspect("Recieved #{inspect(msg)}")
    {:noreply, %{state | count: count + 1}}
  end

  def handle_cast(:stop, state) do
    {:stop, :stopped_by_user, state}
  end

  def handle_call(:count, _from, %{count: count} = state) do
    {:reply, count, state}
  end
end
