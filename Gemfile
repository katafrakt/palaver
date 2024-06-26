# frozen_string_literal: true

source "https://rubygems.org"

gem "rake"

gem "hanami", "~> 2.1.1"
gem "hanami-controller", "~> 2.1.0"
gem "hanami-router", "~> 2.1.0"
gem "hanami-utils", "~> 2.1.0"
gem "hanami-validations", "~> 2.1.0"
gem "hanami-assets", "~> 2.1.0"

gem "argon2", "~> 2.1"
gem "dry-monads"
gem "dry-types", "~> 1.6"
gem "pg"
gem "phlex", "~> 1.6"
gem "puma"
gem "rom", "~> 5.3.0"
gem "rom-sql", "~> 3.6.0"
gem "shrine", "~> 3.6"
gem "shrine-rom"
gem "verifica"
gem "hashids"
gem "stringex"

group :cli, :development do
  gem "hanami-reloader"
end

group :cli, :development, :test do
  gem "dotenv", "~> 2.7"
  gem "faker"
  gem "hanami-rspec"
  gem "standard"
end

group :development do
  gem "guard-puma"
end

group :test do
  gem "database_cleaner-sequel"
  gem "nokolexbor"
  gem "rack-test"
  gem "rom-factory"
  gem "simplecov", require: false
  gem "simplecov-cobertura"
end
