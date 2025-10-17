# frozen_string_literal: true

Hanami.app.register_provider :mailer do
  prepare do
    require "correo"
  end

  start do
    if Hanami.env == :test
      Correo.config.delivery_method = :test
    end

    register "mailer", Correo::Mailer.new
  end
end
