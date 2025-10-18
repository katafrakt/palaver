module Correo
  class Mailer
    # NOTE: perhaps this could offer an override of to:, from: etc.
    def deliver(mail)
      mail.delivery_method(Correo.config.delivery_method)
      mail.deliver
    end
  end
end
