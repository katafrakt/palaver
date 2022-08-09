# frozen_string_literal: true

require "hanami/routes"

module Palaver
  class Routes < Hanami::Routes
    define do
      root { "Hello from Hanami" }
    end
  end
end
