# frozen_string_literal: true

require "simplecov"
SimpleCov.start do
  enable_coverage :branch
  primary_coverage :branch

  add_filter "/spec/"
  add_filter "/config/"
  add_filter "/gems/"

  add_group "Account", "slices/account"
  add_group "Discussion", "slices/discussion"
  add_group "UI", "lib/ui"
end

if ENV["GITHUB_ACTIONS"]
  require "simplecov-cobertura"
  SimpleCov.formatter = SimpleCov::Formatter::CoberturaFormatter
end

require "pathname"
SPEC_ROOT = Pathname(__dir__).realpath.freeze

ENV["HANAMI_ENV"] ||= "test"
require "hanami/prepare"

require_relative "support/rspec"
require_relative "support/requests"
require_relative "support/database_cleaner"
require_relative "support/uploads"
require_relative "support/component_testing"

# Phlex for some reason floods my output with warning about methods being redefined
Warning.extend(Module.new do
  def warn(message, category: nil, **kwargs)
    return if message.match?(/gems\/phlex/)
    super
  end
end)

require "phlex"

require "dry/system/stubs"
Discussion::Container.enable_stubs!
Account::Container.enable_stubs!

require "rom/core"
require "rom/factory"
Factory = ROM::Factory.configure do |config|
  config.rom = Hanami.app["db.rom"]
end

Dir[File.dirname(__FILE__) + "/support/factories/*.rb"].each { |file| require file }
