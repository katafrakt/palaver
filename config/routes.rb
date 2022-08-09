# frozen_string_literal: true

require "hanami/routes"

module Palaver
  class Routes < Hanami::Routes
    define do
      slice :discussion, at: "/" do
        root to: "index.home"
      end
    end
  end
end
