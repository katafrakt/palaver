# frozen_string_literal: true

class Ui::Components::Form::HorizontalSubmit < Phlex::HTML
  def initialize(label: "Submit")
    @label = label
  end

  def view_template
    div(class: "field is-horizontal") do
      div(class: "field-label") do
      end
      div(class: "field-body") do
        div(class: "field") do
          p(class: "control is-expanded") do
            button(class: "button is-primary") { @label }
          end
        end
      end
    end
  end
end
