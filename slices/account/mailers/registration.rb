module Account
  module Mailers
    class Registration < Hanami::Mailer
      include Deps["mailer.configuration"]

      from "accountant@palaver.dev"
      to ->(locals) { locals.fetch(:account).email }

      subject "Account registration"
    end
  end
end
