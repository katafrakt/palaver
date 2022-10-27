# frozen_string_literal: true

require "hanami/rake_tasks"
require 'rom/sql/rake_task'

namespace :db do
  task :setup => :environment do
    ROM::SQL::RakeSupport.env = Hanami.app['persistence.config']
  end

  task seeds: :reset do
    load "db/seeds.rb"
    puts "Seeded"
  end
end