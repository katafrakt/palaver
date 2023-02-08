# frozen_string_literal: true

class Account::Actions::SignIn::Destroy < Account::Action
  def handle(req, res)
    res.session[:usi] = nil
    res.flash[:success] = "You have been signed out"
    res.redirect_to "/"
  end
end