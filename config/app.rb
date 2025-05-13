# frozen_string_literal: true

require "hanami"
require "strict_ivars"

module Palaver
  # By default Hanami tries to find a matching class for current action,
  # infer its name and instantiate it. However, this does not work with Phlex
  # views. Hanami tries to create new instance with no arguments, but Phlex views
  # use arguments in initialization. Therefore we need to disable this feature by
  # creating a fake inferrer that always return empty array.
  class FakeViewNameInferrer
    def self.call(action_class_name:, slice:) = []
  end

  class App < Hanami::App
    config.actions.content_security_policy[:default_src] = "*"
    config.actions.content_security_policy[:style_src] = "*"
    config.actions.content_security_policy[:script_src] = "*"
    config.actions.sessions = :cookie, {secret: ENV["SECRET"]}
    config.middleware.use :body_parser, :form

    # disable default view inferrer
    config.actions.view_name_inferrer = FakeViewNameInferrer
  end
end
