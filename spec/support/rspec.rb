# frozen_string_literal: true

require_relative "helpers"
require_relative "fixtures/account"
require_relative "fixtures/discussion"
require_relative "fixtures/moderation"

RSpec.configure do |config|
  config.extend RSpecHelpers::ClassMethods
  config.include RSpecHelpers::InstanceMethods

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

  config.filter_run_when_matching :focus

  config.disable_monkey_patching!
  config.warnings = true

  if config.files_to_run.one?
    config.default_formatter = "doc"
  end

  config.profile_examples = 10

  config.order = :random
  Kernel.srand config.seed

  config.before(:all) do
    require "argon2"
    Account::Container.stub("utils.hasher", Argon2::Password.new(t_cost: 1, m_cost: 4, p_cost: 1))
    Discussion::Container.stub("utils.slug_provider", ->(string) { string.downcase.tr(" ", "-") })
  end
end
