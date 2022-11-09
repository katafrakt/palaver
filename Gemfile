# frozen_string_literal: true

source "https://rubygems.org"

gem "rake"

gem "hanami-router", "~> 2.0.0.rc"
gem "hanami-controller", "~> 2.0.0.rc"
gem "hanami", "~> 2.0.0.rc"

gem "dry-types", "~> 1.6"
gem "pg"
gem "phlex"
gem "puma"
gem "rom-sql", git: "https://github.com/rom-rb/rom-sql.git" # "~> 4.0.0.alpha"
gem "rom", git: "https://github.com/rom-rb/rom.git"
gem "dry-transformer", git: "https://github.com/dry-rb/dry-transformer.git"

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
end
