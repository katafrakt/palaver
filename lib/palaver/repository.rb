# frozen_string_literal: true

require "rom-repository"

module Palaver
  class Repository < ROM::Repository::Root
    include Deps[container: "db.rom"]
  end
end
