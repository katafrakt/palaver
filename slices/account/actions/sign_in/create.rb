# frozen_string_literal: true

class Account::Actions::SignIn::Create < Account::Action
  include Account::Deps["commands.sign_in"]

  require_signed_out_user!

  params do
    required(:email).filled(:str?, format?: URI::MailTo::EMAIL_REGEXP)
    required(:password).filled(:str?)
  end

  def handle(req, res)
    render_on_invalid_params(res, Account::Views::SignIn::New)

    case sign_in.call(req.params[:email], req.params[:password])
    in Success(user)
      res.session[:usi] = user.id
      res.flash[:success] = "Successfully signed in"
      # TODO: remember where to redirect back
      res.redirect_to "/"
    else
      res.flash[:error] = "Incorrect email or password"
      res.redirect_to "/account/sign_in"
    end
  end
end
