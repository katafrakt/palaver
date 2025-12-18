# frozen_string_literal: true

source "https://gem.coop"

gem "rake"

HANAMI_VERSION = "2.3.0"
gem "hanami", "2.3.1"
gem "hanami-controller", HANAMI_VERSION
gem "hanami-router", HANAMI_VERSION
gem "hanami-utils", HANAMI_VERSION
gem "hanami-validations", HANAMI_VERSION
gem "hanami-assets", HANAMI_VERSION
gem "hanami-db", HANAMI_VERSION
gem "hanami-cli", "2.3.2"

gem "argon2", "~> 2.1"
gem "dry-monads"
gem "dry-types", "~> 1.6"
gem "pg"
gem "phlex", "~> 2.3.0"
gem "puma"
gem "shrine", "~> 3.6"
gem "marcel", "~> 1.1.0"
gem "shrine-rom"
gem "verifica"
gem "hashids"
gem "base64"
gem "stringex"
gem "dry-operation", "~> 1.0"

gem "correo", path: "gems/correo"

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
