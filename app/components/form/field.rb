# frozen_string_literal: true

class Palaver::Components::Form::Field < Phlex::View
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
    input(class: classes, name: name, type: type.to_s, placeholder: placeholder, value: value)
  end
end
