# frozen_string_literal: true

class Account::Actions::Registration::Create < Account::Action
  include Account::Deps["commands.register_user"]

  require_signed_out_user!

  contract do
    schema do
      required(:email).filled(:str?, format?: URI::MailTo::EMAIL_REGEXP)
      required(:password).filled(:str?, min_size?: 8)
      required(:password_confirmation).filled(:str?, min_size?: 8)
    end

    rule(:password_confirmation, :password) do
      key.failure("passwords do not match") if values[:password] != values[:password_confirmation]
    end
  end

  def handle(req, res)
    render_on_invalid_params(res, Account::Templates::Registration::New)

    case register_user.call(req.params[:email], req.params[:password])
    in Success(account)
      res.render(Account::Templates::Registration::AfterCreate, account:)
    else
      email_error = "must be unique"
      res.status = 422
      res.render(Account::Templates::Registration::New, values: req.params.to_h, errors: {email: [email_error]})
    end
  end
end
