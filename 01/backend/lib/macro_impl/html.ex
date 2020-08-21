defmodule HtmlImpl do
  require Logger
  import Html

  def render do
    markup do
      div id: "main" do
        h1(
          class: "title",
          do: text("Welcome!")
        )

        div class: "row" do
          div class: "column" do
            p("Hello!")
          end
        end

        button onclick: "javascript: history.go(-1);" do
          text("Back")
        end
      end
    end
  end
end
