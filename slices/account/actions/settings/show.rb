# frozen_string_literal: true

module Account
  module Actions
    module Settings
      class Show < Account::Action
        require_signed_in_user!

        def handle(req, res)
          case req.params[:tab]
          when "account"
            res.render(Account::Views::Settings::Auth, errors: {}, values: {})
          when "profile"
            res.render(Account::Views::Settings::Profile, errors: {}, values: {})
          else
            res.flash[:error] = "Unknown settings area"
            res.redirect "/"
          end
        end
      end
    end
  end
end
