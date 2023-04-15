# frozen_string_literal: true

class Discussion::Components::HomeTabs < Phlex::HTML
  attr_reader :selected

  def initialize(selected)
    @selected = selected
  end

  def template
    div(class: "tabs") do
      ul do
        tab("/", "Categories", :categories)
        tab("/recent", "Recently updated", :recent)
        tab("/new_threads", "New threads", :new)
      end
    end
  end

  def tab(url, label, type)
    class_string = (type == @selected) ? "is-active" : ""

    li(class: class_string) do
      a(href: url) { label }
    end
  end
end
