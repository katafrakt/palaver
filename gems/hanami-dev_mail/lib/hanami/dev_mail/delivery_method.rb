module Hanami
  module DevMail
    class DeliveryMethod
      def initialize(options)
        @options = options
      end

      def deliver!(mail)
        p mail
      end
    end
  end
end
