# frozen_string_literal: true

require "hanami"

module Palaver
  class App < Hanami::App
    config.actions.content_security_policy[:default_src] = "*"
    config.actions.content_security_policy[:style_src] = "*"
    config.actions.content_security_policy[:script_src] = "*"
    config.actions.sessions = :cookie, {secret: ENV["SECRET"]}
  end
end
