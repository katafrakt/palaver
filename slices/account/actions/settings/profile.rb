module Account
  module Actions
    module Settings
      class Profile < Account::Action
        require_signed_in_user!

        def handle(req, res)
          res.render(Account::Views::Settings::Profile)
        end
      end
    end
  end
end
