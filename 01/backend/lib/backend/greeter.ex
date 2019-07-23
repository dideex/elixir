defmodule Backend.Greeter do
  @moduledoc """
  Just greeting
  @param: name<String>
  """
  @greeting Application.fetch_env!(:backend, :greeting)

  def greeting(name) do
    @greeting <> ", #{name}"
  end
end
