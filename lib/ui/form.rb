module Ui
  module Form
    def hidden_field(name, value)
      input(name: name, value: value, type: "hidden")
    end

    def horizontal_field(label:, name:, placeholder: "", type: "text", value: nil, error: nil)
      render Palaver::Components::Form::HorizontalField.new(label: label, name: name, placeholder: placeholder, type: type, value: value, error: error)
    end
  end
end
