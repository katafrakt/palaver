# frozen_string_literal: true

class Account::Actions::Registration::Create < Account::Action
  include Account::Deps["operations.register", mailer: "mailers.registration"]

  require_signed_out_user!

  class Schema < Dry::Validation::Contract
    params do
      required(:email).filled(:str?, format?: URI::MailTo::EMAIL_REGEXP)
      required(:password).filled(:str?, min_size?: 8)
      required(:password_confirmation).filled(:str?, min_size?: 8)
    end

    rule(:password_confirmation, :password) do
      key.failure("passwords do not match") if values[:password] != values[:password_confirmation]
    end
  end
  contract Schema

  def handle(req, res)
    render_on_invalid_params(res, Account::Views::Registration::New)

    case register.call(email: req.params[:email], password: req.params[:password])
    in Success(account)
      mailer.deliver(account:)
      res.render(Account::Views::Registration::AfterCreate, account:)
    else
      email_error = "must be unique"
      res.status = 422
      res.render(Account::Views::Registration::New, values: req.params.to_h, errors: {email: [email_error]})
    end
  end
end
