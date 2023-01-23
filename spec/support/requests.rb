# frozen_string_literal: true

require "rack/test"

RSpec.shared_context "Hanami app" do
  let(:app) { Hanami.app }
end

RSpec.configure do |config|
  config.include Rack::Test::Methods, type: :request
  config.include_context "Hanami app", type: :request

  config.after(type: :request) do
    DatabaseCleaner[:sequel].clean
  end

  config.after(type: :db) do
    DatabaseCleaner[:sequel].clean
  end
end

DatabaseCleaner[:sequel].db = Hanami.app["persistence.db"]
DatabaseCleaner[:sequel].strategy = :truncation
