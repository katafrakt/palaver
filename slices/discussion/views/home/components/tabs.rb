# frozen_string_literal: true

class Discussion::Views::Home::Components::Tabs < Phlex::HTML
  attr_reader :selected

  def initialize(selected)
    @selected = selected
  end

  def view_template
    ul(class: "nav nav-underline my-4") do
      tab("/", "Categories", :categories)
      tab("/recent", "Recently updated", :recent)
      tab("/new_threads", "New threads", :new)
    end
  end

  def tab(url, label, type)
    class_string = (type == @selected) ? " active" : ""

    li(class: "nav-item") do
      a(href: url, class: "nav-link#{class_string}") { label }
    end
  end
end
