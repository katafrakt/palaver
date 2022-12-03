# frozen_string_literal: true

require "simplecov"
SimpleCov.start do
  enable_coverage :branch
  primary_coverage :branch
  add_filter "/spec/"
  add_filter "/config/"
  add_group "App", "app"
  add_group "Account", "slices/account"
  add_group "Discussion", "slices/discussion"
end

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

require "dry/system/stubs"
Discussion::Container.enable_stubs!
Account::Container.enable_stubs!

require "rom/core"
require "rom/factory"
Factory = ROM::Factory.configure do |config|
  config.rom = Hanami.app["persistence.rom"]
end

Dir[File.dirname(__FILE__) + "/support/factories/*.rb"].each { |file| require file }
