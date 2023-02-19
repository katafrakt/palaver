# frozen_string_literal: true

require "hanami"
require "hanami/middleware/body_parser"

module Palaver
  class App < Hanami::App
    config.actions.content_security_policy[:default_src] = "*"
    config.actions.content_security_policy[:style_src] = "*"
    config.actions.content_security_policy[:script_src] = "*"
    config.actions.sessions = :cookie, {secret: ENV["SECRET"]}
    config.middleware.use Hanami::Middleware::BodyParser, :form
  end
end
