# frozen_string_literal: true

class Account::Actions::SignIn::Create < Account::Action
  include Account::Deps["commands.sign_in"]

  params do
    required(:email).filled(:str?, format?: URI::MailTo::EMAIL_REGEXP)
    required(:password).filled(:str?)
  end

  def handle(req, res)
    render_on_invalid_params(res, Account::Templates::SignIn::New)

    case re = sign_in_user.call(req.params[:email], req.params[:password])
    in [:ok, account]
    res.body = account
    else
      res.body = re
    end
  end
end
