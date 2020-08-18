defmodule HtmlImpl do
  require Logger
  import Html

  def render do
    markup do
      tag :div do
        tag :span do
          Logger.info "We can mix regular Elixir code here"
          text "Nested tags are no trouble for our buffer"
        end
      end
    end
  end
end
