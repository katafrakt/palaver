# frozen_string_literal: true

class Ui::Components::Form::Submit < Phlex::HTML
  def initialize(label: "Submit")
    @label = label
  end

  def view_template
    div do
      button(type: "submit", class: "btn btn-primary") { @label }
    end
  end
end
