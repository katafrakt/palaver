# frozen_string_literal: true

class Ui::Components::Form::Field < Phlex::HTML
  attr_reader :type, :name, :placeholder, :value

  # NOTE: We are not creating a getter for label, because it conflicts with label method
  # from Phlex
  def initialize(label:, name:, type: :text, placeholder: nil, value: nil, error: nil, disabled: false)
    @type = type
    @label = label
    @name = name
    @placeholder = placeholder
    @value = value
    @error = error
    @disabled = disabled
  end

  def view_template
    div do
      label(class: "form-label") { @label }
      render_input(disabled: @disabled)
      if @error
        div(class: "invalid-feedback") { @error.join(", ") }
      end
    end
  end

  private

  def render_input(disabled: false)
    classes = ["form-control", @error.nil? ? nil : "is-invalid"].compact.join(" ")
    case type
    when :textarea
      textarea(class: classes, name: name, rows: 5) { value || placeholder }
    when :file
      input(class: "form-control", type: "file", name: name)
    else
      input(class: classes, name: name, type: type.to_s, placeholder: placeholder, value: value, disabled: disabled)
    end
  end
end
