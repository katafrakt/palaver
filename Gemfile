# frozen_string_literal: true

source "https://rubygems.org"

gem "rake"

HANAMI_VERSION = "~> 2.1.0.beta"
gem "hanami", HANAMI_VERSION
gem "hanami-controller", HANAMI_VERSION
gem "hanami-router", HANAMI_VERSION
gem "hanami-utils", HANAMI_VERSION
gem "hanami-validations", HANAMI_VERSION
gem "hanami-assets", HANAMI_VERSION

gem "argon2", "~> 2.1"
gem "dry-monads"
gem "dry-types", "~> 1.6"
gem "pg"
gem "phlex", "~> 1.6"
gem "puma"
gem "rom", "~> 5.3.0"
gem "rom-sql", "~> 3.6.0"
gem "shrine", "~> 3.0"
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
end
