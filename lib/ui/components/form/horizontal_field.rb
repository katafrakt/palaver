# frozen_string_literal: true

class Ui::Components::Form::HorizontalField < Ui::Components::Form::Field
  def template
    div(class: "field is-horizontal") do
      div(class: "field-label is-normal") do
        label(class: "label") { @label }
      end
      div(class: "field-body") do
        div(class: "field") do
          p(class: "control is-expanded") do
            render_input(disabled: @disabled)
          end
          if @error
            p(class: "help is-danger") { @error.join(", ") }
          end
        end
      end
    end
  end
end
