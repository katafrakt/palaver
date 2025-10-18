require "dry/configurable"

module Correo
  class Configuration
    extend Dry::Configurable

    setting :delivery_method, default: :logger
  end
end
