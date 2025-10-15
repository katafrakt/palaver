module Account
  module Actions
    module Settings
      class UpdateProfile < Account::Action
        include Deps["operations.update_profile", repo: "repositories.profile"]

        require_signed_in_user!

        params do
          optional(:avatar)
          optional(:nickname).maybe(:string)
        end

        def handle(req, res)
          current_user = res[:current_user]

          case update_profile.call(current_user, req.params.to_h)
          in Success(_)
            res.flash[:success] = "Profile updated"
            res.redirect_to "/account/settings/profile"
          end
        end
      end
    end
  end
end
