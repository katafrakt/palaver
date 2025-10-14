# frozen_string_literal: true

require "rack/test"
require_relative "request_helpers"

RSpec.shared_context "Hanami app" do
  let(:app) { Hanami.app }
end

RSpec.configure do |config|
  config.include Rack::Test::Methods, type: :request
  config.include RequestHelpers, type: :request
  config.include_context "Hanami app", type: :request
end
