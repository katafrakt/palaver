require "mail"
require "hanami/utils/class_attribute"

module Correo
  class Email
    include Hanami::Utils::ClassAttribute

    class_attribute :html_template

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

    def build(args)
      # if class.html_template s not avaiable, this could fall back to Hanami's default
      # template lookup logic
      html_part = self.class.html_template.new(**args).call if self.class.html_template

      Mail.new.tap do |mail|
        mail.to = to
        mail.from = from
        mail.subject = subject

        if html_part
          mail.html_part = Mail::Part.new do
            content_type "text/html; charset=UTF-8"
            body html_part
          end
        end
      end
    end
  end
end
