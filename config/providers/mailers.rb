Hanami.app.register_provider :mailers, namespace: true do
  prepare do
    require "mail"
    require "mailer/logger_delivery"
  end

  start do
    delivery_method =
      case Hanami.env
      when :test
        Hanami::Mailer::Delivery::Test.new
      when :development
        Palaver::Mailer::LoggerDelivery.new(logger: Hanami.app["logger"], severity: :info)
      when :production
        :smtp
      end

    register "delivery_method", delivery_method
  end
end
