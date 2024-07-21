# frozen_string_literal: true

require "hanami/rake_tasks"

namespace :db do
  task :seeds do
    migrate = Hanami::CLI::Commands::App::DB::Migrate.new
    migrate.call(target: 0)
    migrate.call
    Hanami::CLI::Commands::App::DB::Seed.new.call
    puts "Seeded"
  end
end
