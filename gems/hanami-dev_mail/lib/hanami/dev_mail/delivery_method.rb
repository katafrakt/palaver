require_relative "storage"

module Hanami
  module DevMail
    class DeliveryMethod
      def initialize(options)
        @options = options
      end

      def deliver!(mail)
        p mail
        p mail.body
        storage = Storage.new(file: "/tmp/palaver-mails", items_limit: 20)
        storage.add(mail)
      end
    end
  end
end
