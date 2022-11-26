class Account::Actions::Registration::Confirm < Account::Action
  include Account::Deps["commands.confirm_user"]

  params do
    required(:id).filled(:integer)
    required(:token).filled(:str?)
  end

  def handle(req, res)
    result = validate_params(req).bind do
      confirm_user.call(req.params[:id], req.params[:token])
    end

    case result
    when Failure(:invalid_params)
      handle_failure("Incorrect confirmation link")
    when Failure(:user_not_found)
      handle_failure("Incorrect confirmation link", status: 404)
    when Failure(:already_confirmed)
      handle_failure(res, "User is already confirmed")
    when Success()
      res.flash[:success] = "User confirmed. You can now sign in."
      res.redirect_to "/account/sign_in"
    end
  end

  private

  def handle_failure(res, message, status: 422)
    res.flash[:error] = message
    res.status = status
    res.redirect_to "/"
  end
end
