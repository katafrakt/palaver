# frozen_string_literal: true

class Palaver::Components::Form::Field < Phlex::HTML
  attr_reader :type, :name, :placeholder, :value

  # NOTE: We are not creating a getter fot label, because it conflicts with label method
  # from Phlex
  def initialize(label:, name:, type: :text, placeholder: nil, value: nil, error: nil)
    @type = type
    @label = label
    @name = name
    @placeholder = placeholder
    @value = value
    @error = error
  end

  def template
    div(class: "field") do
      label(class: "label") { @label }
      render_input
    end
  end

  private

  def render_input
    classes = ["input", @error.nil? ? nil : "is-danger"].compact.join(" ")
    case type
    when :textarea
      classes = ["textarea", @error.nil? ? nil : "is-danger"].compact.join(" ")
      textarea(class: classes, name: name, rows: 5) { value || placeholder }
    when :file
      label(class: "file-label") do
        input(class: "file-input", type: "file", name: name)
        span(class: "file-cta") do
          span(class: "file-icon") do
            i(class: "fas fa-upload")
          end
          span(class: "file-label") { "Choose a file" }
        end
      end
    else
      input(class: classes, name: name, type: type.to_s, placeholder: placeholder, value: value)
    end
  end
end
