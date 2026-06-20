module Palaver
  module Mailer
    # I hoped to reuse Mail::LoggerDelivery here, perhaps with a little API wrapper
    # aliasing `call` to `deliver!`), but they turn out to not be compatible,
    # hence the custom implementation.
    class LoggerDelivery
      def initialize(logger:, severity: :info)
        @logger = logger
        @severity = severity
      end

      def call(message)
        @logger.public_send(@severity, build_message(message))
      end

      private

      def build_message(message)
        [
          "FROM: #{message.from.join(", ")}",
          "TO: #{message.to.join(", ")}",
          message.cc ? "CC: #{message.cc}" : nil,
          message.bcc ? "BCC: #{message.bcc}" : nil,
          "SUBJECT: #{message.subject}",
          "",
          # TODO support and prioritize text format here
          message.html_body
        ].compact.join("\n")
      end
    end
  end
end
