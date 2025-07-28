# frozen_string_literal: true

Hanami.app.register_provider :mailer, namespace: true do
  prepare do
    require "hanami/mailer"
    require "hanami/dev_mail"

    configuration = Hanami::Mailer::Configuration.new do |config|
      config.delivery_method = Hanami::DevMail::DeliveryMethod
    end

    register "configuration", configuration
  end

  start do
    configuration = target["mailer.configuration"]

    # we need to manually load every mailer here, before finalizing
    Account::Mailers::Registration

    Hanami::Mailer.finalize(configuration)
  end
end
