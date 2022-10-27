# frozen_string_literal: true

source "https://rubygems.org"

gem "rake"

gem "hanami-router", "~> 2.0.0.beta"
gem "hanami-controller", "~> 2.0.0.beta"
gem "hanami", "~> 2.0.0.beta"

gem 'phlex'

gem "puma"

group :cli, :development do
  gem "hanami-reloader"
end

group :cli, :development, :test do
  gem "hanami-rspec"
  gem "dotenv", "~> 2.7"
end

group :development do
  gem "guard-puma"
end

group :test do
  gem "rack-test"
end

gem "dry-types", "~> 1.6"

gem "rom-sql", "~> 3.5"

gem "sqlite3", "~> 1.5"
