# frozen_string_literal: true

module Ui
  module Components
    class Form < Phlex::HTML
      include Ui::Form
      attr_reader :url

      def initialize(url:, multipart: false)
        @url = url
        @multipart = multipart
      end

      def template(&content)
        params = {method: "POST", action: url}
        params[:enctype] = "multipart/form-data" if @multipart
        form(**params, &content)
      end

      def section_title(title, pad_top: false)
        extra_classes = pad_top ? " pt-5" : ""
        h4(class: "is-size-4 pb-2 mb-2#{extra_classes}") { title }
      end
    end
  end
end
