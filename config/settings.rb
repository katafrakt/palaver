# frozen_string_literal: true

require "palaver/types"
require "hanami/settings"

module Palaver
  class Settings < Hanami::Settings
    setting :database_url, constructor: Types::String
  end
end
