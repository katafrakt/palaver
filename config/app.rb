# frozen_string_literal: true

require "hanami"
# Must be required before the app and slices are prepared: requiring it installs
# the hooks that register Phlex classes in slice containers as classes.
require "phlex/hanami"

module Palaver
  class App < Hanami::App
    config.actions.content_security_policy[:default_src] = "*"
    config.actions.content_security_policy[:style_src] = "*"
    config.actions.content_security_policy[:script_src] = "*"
    config.actions.sessions = :cookie, {secret: ENV["SECRET"]}
    config.middleware.use :body_parser, :form

    config.shared_app_component_keys += ["mailers.delivery_method"]
  end
end
