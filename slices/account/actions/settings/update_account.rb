# frozen_string_literal: true

require "argon2"
require "dry/monads"
require "dry/monads/do"
require "hanami/utils/blank"

module Account
  module Actions
    module Settings
      class UpdateAccount < Account::Action
        include Deps["operations.update_account", repo: "repositories.account"]

        require_signed_in_user!

        contract do
          params do
            optional(:current_password).maybe(:string)
            optional(:new_password).maybe(:string, min_size?: 8)
            optional(:new_password_confirmation).maybe(:string, min_size?: 8)
          end

          rule(:new_password_confirmation, :new_password) do
            key.failure("passwords do not match") if values[:new_password] != values[:new_password_confirmation]
          end
        end

        def handle(req, res)
          current_user = res[:current_user]
          return render_show(req, res) unless validate_params(req).success?

          case update_account.call(current_user, req.params.to_h)
          in Failure(:current_password_invalid)
            req.params.errors[:current_password] = ["incorrect password"]
            render_show(req, res)
          in Success(_)
            res.flash[:success] = "Settings saved"
            res.redirect_to "/account/settings/account"
          end
        end

        private

        def render_show(req, res)
          current_user = res[:current_user]
          settings = repo.settings_by_user_id(current_user.id)
          res.render(Account::Views::Settings::Auth, settings:, errors: req.params.errors, values: req.params.to_h)
        end
      end
    end
  end
end
