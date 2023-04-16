# frozen_string_literal: true

require "hanami/routes"

module Palaver
  class Routes < Hanami::Routes
    slice :discussion, at: "/"
    slice :account, at: "/account"
    slice :moderation, at: "/moderation"
  end
end
