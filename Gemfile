# frozen_string_literal: true

source "https://rubygems.org"

gem "rake"

gem "hanami-router", "~> 2.0.0"
gem "hanami-controller", "~> 2.0.0"
gem "hanami-validations", "~> 2.0.0"
gem "hanami", "~> 2.0.0"
gem "hanami-utils", "~> 2.0.0" #, github: "hanami/utils", branch: "add-equalizer-to-callback-chain"

gem "argon2", "~> 2.1"
gem "dry-types", "~> 1.6"
gem "dry-monads"
gem "pg"
gem "phlex", "~> 1.2.0"
gem "puma"
gem "rom-sql", "~> 3.6.0"
gem "rom", "~> 5.3.0"
gem "verifica"
gem "shrine", "~> 3.0"
gem "shrine-rom"

group :cli, :development do
  gem "hanami-reloader"
end

group :cli, :development, :test do
  gem "hanami-rspec"
  gem "dotenv", "~> 2.7"
  gem "standard"
  gem "faker"
end

group :development do
  gem "guard-puma"
end

group :test do
  gem "rack-test"
  gem "simplecov", require: false
  gem "rom-factory"
  gem "oga"
  gem "database_cleaner-sequel"
end
