require "mail"

module Correo
  class Email
    def to
      raise NotImplementedError
    end

    def from
      raise NotImplementedError
    end

    def subject
      raise NotImplementedError
    end

    def html_part = nil

    def deliver
      html_content = html_part

      Mail.new.tap do |mail|
        mail.delivery_method(Correo.config.delivery_method)
        mail.to = to
        mail.from = from

        if html_part
          mail.html_part = Mail::Part.new do
            content_type "text/html; charset=UTF-8"
            body html_part
          end
        end
      end.deliver
    end
  end
end
