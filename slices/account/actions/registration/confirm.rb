class Account::Actions::Registration::Confirm < Account::Action
  include Account::Deps["commands.confirm_user"]

  params do
    required(:id).filled(:int?)
    required(:token).filled(:str?)
  end

  def handle(req, res)
    if !req.params.valid?
      res.flash[:error] = "Incorrect confirmation link"
      res.status = 422
      res.redirect_to "/"
    end
  end
end
