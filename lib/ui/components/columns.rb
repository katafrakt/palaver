# frozen_string_literal: true

module Ui
  module Components
    class Columns < Phlex::HTML
      def template(&)
        div(class: "columns", &)
      end

      def column(&)
        div(class: "column", &)
      end
    end
  end
end
