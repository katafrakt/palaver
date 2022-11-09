# frozen_string_literal: true

require "hanami/rake_tasks"
require "rom/sql/rake_task"

namespace :db do
  task setup: :environment do
    require "rom/core"
    rom_config = ROM::Configuration.new(:sql, Hanami.app["settings"].database_url)
    ROM::SQL::RakeSupport.env = rom_config
  end

  task seeds: :reset do
    load "db/seeds.rb"
    puts "Seeded"
  end
end
