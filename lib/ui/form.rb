module Ui
  module Form
    def hidden_field(name, value)
      input(name: name, value: value, type: "hidden")
    end

    def horizontal_field(label:, name:, placeholder: "", type: "text", value: nil, error: nil, disabled: false)
      render Ui::Components::Form::HorizontalField.new(label:, name:, placeholder:, type:, value:, error:, disabled:)
    end

    def submit(label)
      render Ui::Components::Form::HorizontalSubmit.new(label:)
    end

    def csrf(token)
      hidden_field("_csrf_token", token)
    end
  end
end
