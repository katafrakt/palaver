# frozen_string_literal: true

class Account::Actions::SignIn::Create < Account::Action
  include Account::Deps["commands.sign_in"]

  params do
    required(:email).filled(:str?, format?: URI::MailTo::EMAIL_REGEXP)
    required(:password).filled(:str?)
  end

  def handle(req, res)
    render_on_invalid_params(res, Account::Templates::SignIn::New)

    case re = sign_in.call(req.params[:email], req.params[:password])
    in [:ok, account]
      res.body = "Signed in user #{account.id}"
    else
      res.flash[:error] = "Incorrect email or password"
      res.redirect_to "/account/sign_in"
    end
  end
end
