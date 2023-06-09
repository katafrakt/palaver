module Ui
  module Form
    def hidden_field(name, value)
      input(name: name, value: value, type: "hidden")
    end

    def horizontal_field(label:, name:, placeholder: "", type: "text", value: nil, error: nil)
      render Ui::Components::Form::HorizontalField.new(label:, name:, placeholder:, type:, value:, error:)
    end

    def field_info
      div(class: "field is-horizontal") do
        div(class: "field-label is-normal")
        div(class: "field-body") do
          div(class: "field") do
            p(class: "control is-expanded") do
              yield
            end
          end
        end
      end
    end
  end
end
