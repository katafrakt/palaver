# frozen_string_literal: true

source "https://rubygems.org"

gem "rake"

HANAMI_VERSION = "2.2.0"
gem "hanami", HANAMI_VERSION
gem "hanami-controller", HANAMI_VERSION
gem "hanami-router", HANAMI_VERSION
gem "hanami-utils", HANAMI_VERSION
gem "hanami-validations", HANAMI_VERSION
gem "hanami-assets", HANAMI_VERSION
gem "hanami-db", HANAMI_VERSION

gem "argon2", "~> 2.1"
gem "dry-monads"
gem "dry-types", "~> 1.6"
gem "pg"
gem "phlex", "~> 2.0.0.rc"
gem "puma"
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
  gem "hanami-rspec", HANAMI_VERSION
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
