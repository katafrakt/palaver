require "database_cleaner/sequel"

DatabaseCleaner[:sequel].db = Hanami.app["persistence.db"]
DatabaseCleaner[:sequel].strategy = :transaction

RSpec.configure do |config|
  config.before :suite do
    DatabaseCleaner[:sequel].clean_with :truncation
  end

  config.prepend_before :each do
    DatabaseCleaner[:sequel].strategy = :transaction
    DatabaseCleaner[:sequel].start
  end

  config.append_after :each do
    DatabaseCleaner[:sequel].clean
  end
end
