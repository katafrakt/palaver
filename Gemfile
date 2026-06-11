# frozen_string_literal: true

source "https://gem.coop"

gem "rake"

gem "hanami", "3.0.0.rc1"
gem "hanami-action", "3.0.0.rc1"
gem "hanami-router", "3.0.0.rc1"
gem "hanami-utils", "3.0.0.rc1"
gem "hanami-assets", "3.0.0.rc1"
gem "hanami-db", "3.0.0.rc1"
gem "hanami-cli", "3.0.0.rc1"

gem "argon2", "~> 2.1"
gem "pg"
gem "phlex", "~> 2.3.0"
gem "puma"
gem "shrine", "~> 3.6"
gem "marcel", "~> 1.1.0"
gem "shrine-rom"
gem "verifica"
gem "hashids"
gem "base64"
gem "diaeresis", git: "https://codeberg.org/katafrakt/diaeresis.git"

source "https://gem.coop/@dry" do
  gem "dry-types", "~> 1.7"
  gem "dry-operation", ">= 1.0.1"
  gem "dry-validation", "~> 1.11"
end

gem "correo", path: "gems/correo"

group :cli, :development do
  gem "hanami-reloader", "3.0.0.rc1"
end

group :cli, :development, :test do
  gem "dotenv", "~> 2.7"
  gem "faker"
  gem "hanami-rspec", "3.0.0.rc1"
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
