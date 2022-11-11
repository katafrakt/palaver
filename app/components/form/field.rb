# frozen_string_literal: true

class Palaver::Components::Form::Field < Phlex::View
  attr_reader :type, :name, :placeholder, :value

  # NOTE: We are not creating a getter fot label, because it conflicts with label method
  # from Phlex
  def initialize(type: :text, label:, name:, placeholder: nil, value: nil)
    @type = type
    @label = label
    @name = name
    @placeholder = placeholder
    @value = value
  end

  def template
    div(class: "field") do
      label(class: "label") { @label }
      render_input
    end
  end

  private

  def render_input
      input(class: "input", type: type.to_s, placeholder: placeholder, value: value)
  end
end
