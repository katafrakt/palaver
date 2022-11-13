# frozen_string_literal: true

source "https://rubygems.org"

gem "rake"

gem "hanami-router", "~> 2.0.0.rc"
gem "hanami-controller", "~> 2.0.0.rc"
gem "hanami-validations", "~> 2.0.0.rc"
gem "hanami", "~> 2.0.0.rc"

gem "argon2", "~> 2.1"
gem "dry-types", "~> 1.6"
gem "pg"
gem "phlex"
gem "puma"
gem "rom-sql", "~> 3.6.0"
gem "rom", "~> 5.3.0"
gem "warden", "~> 1.2"

group :cli, :development do
  gem "hanami-reloader"
end

group :cli, :development, :test do
  gem "hanami-rspec"
  gem "dotenv", "~> 2.7"
  gem "standard"
end

group :development do
  gem "guard-puma"
end

group :test do
  gem "rack-test"
  gem "simplecov", require: false
  gem "faker"
  gem "rom-factory"
  gem "oga"
  gem "database_cleaner-sequel"
end
