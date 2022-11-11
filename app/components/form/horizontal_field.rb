# frozen_string_literal: true

class Palaver::Components::Form::HorizontalField < Palaver::Components::Form::Field
  def template
    div(class: "field is-horizontal") do
      div(class: "field-label is-normal") do
        label(class: "label") { @label }
      end
      div(class: "field-body") do
        div(class: "field") do
          p(class: "control is-expanded") do
            render_input
          end
        end
      end
    end
  end
end
