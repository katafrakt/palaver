# frozen_string_literal: true

require "pathname"
SPEC_ROOT = Pathname(__dir__).realpath.freeze

ENV["HANAMI_ENV"] ||= "test"
require "hanami/prepare"

require_relative "support/rspec"
require_relative "support/requests"
require "phlex"

# NOTE: for some reason I cannot just require it, so copying from source code
module Phlex
  module Testing
    module ViewHelper
      def render(view, &block)
        view.call(view_context: view_context, &block)
      end

      def view_context
        nil
      end
    end
  end
end
