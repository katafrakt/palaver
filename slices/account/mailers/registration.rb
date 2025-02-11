module Account
  module Mailers
    class Registration < Hanami::Mailer
      include Deps["mailer.configuration"]

      from "accountant@palaver.dev"
      to ->(locals) { locals.fetch(:account).email }

      subject "Account registration"
      path = Pathname.new(File.join(__dir__, "registration")).relative_path_from(Hanami.app.root).to_s
      template path
    end
  end
end
