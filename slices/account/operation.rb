# auto_register: false
# frozen_string_literal: true

require "dry/operation"

module Account
  class Operation < Dry::Operation
    # TODO check if needed
    include Dry::Monads[:result]
  end
end
