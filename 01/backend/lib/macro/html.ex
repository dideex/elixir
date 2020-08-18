defmodule Html do

  defmacro markup(do: block) do
    quote do
      {:ok, var!(buffer, __MODULE__)} = start_buffer([])
      unquote(block)
      result = render(var!(buffer, __MODULE__))
      :ok = stop_buffer(var!(buffer, __MODULE__))
      result
    end
  end

  def start_buffer(state),
    do: Agent.start_link(fn -> state end)

  def stop_buffer(buff),
    do: Agent.stop(buff)

  def put_buffer(buff, content),
    do: Agent.update(buff, &[content | &1])

  def render(buff),
    do: Agent.get(buff, & &1) |> Enum.reverse() |> Enum.join("")

  defmacro tag(name, do: inner) do
    quote do
      put_buffer(var!(buffer, __MODULE__), "<#{unquote(name)}>")
      unquote(inner)
      put_buffer(var!(buffer, __MODULE__), "</#{unquote(name)}>")
    end
  end

  defmacro text(string) do
    quote do
      put_buffer(var!(buffer, __MODULE__), to_string(unquote(string)))
    end
  end
end
