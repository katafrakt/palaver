# frozen_string_literal: true

Hanami.app.register_provider :persistence, namespace: true do
  prepare do
    require "rom/core"
    require "rom-changeset"
    require "rom/sql"

    rom_config = ROM::Configuration.new(:sql, target["settings"].database_url)

    rom_config.plugin(:sql, relations: :instrumentation) do |plugin_config|
      plugin_config.notifications = target["notifications"]
    end

    rom_config.plugin(:sql, relations: :auto_restrictions)
    rom_config.plugin(:sql, relations: :pagination)
    rom_config.gateways[:default].use_logger(Logger.new($stdout)) if ENV["LOG_SQL"]

    register "config", rom_config
    register "db", rom_config.gateways[:default].connection
  end

  start do
    config = target["persistence.config"]
    config.auto_registration target.root.join("lib/palaver/persistence")

    register "rom", ROM.container(config)
  end
end
