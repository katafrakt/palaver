# frozen_string_literal: true

require_relative "correo/version"
require_relative "correo/email"
require_relative "correo/mailer"
require "dry/configurable"

module Correo
  extend Dry::Configurable

  setting :delivery_method, default: :logger
end
