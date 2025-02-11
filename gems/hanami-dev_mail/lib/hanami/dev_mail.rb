# frozen_string_literal: true

require_relative "dev_mail/version"
require_relative "dev_mail/delivery_method"
require_relative "dev_mail/slice"

module Hanami
  module DevMail
    SLICE_NAME = :hanami_dev_mail
    extend Dry::Configurable

    setting :url_prefix

    def self.url_prefix = self.config.url_prefix
  end
end

# register the slice
Hanami.app.register_slice Hanami::DevMail::SLICE_NAME, Hanami::DevMail::Slice
