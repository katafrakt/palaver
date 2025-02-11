# frozen_string_literal: true

require "hanami/routes"
require "hanami/dev_mail/router_extension"

module Palaver
  class Routes < Hanami::Routes
    extend Hanami::DevMail::RouterExtension

    slice :discussion, at: "/"
    slice :account, at: "/account"
    slice :moderation, at: "/moderation"

    if Hanami.env == :development
      mount_dev_mail(at: "/emails")
    end
  end
end
