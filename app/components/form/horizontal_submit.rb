# frozen_string_literal: true

class Palaver::Components::Form::HorizontalSubmit < Phlex::View
  def initialize(label: "Submit")
    @label = label
  end

  def template
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
