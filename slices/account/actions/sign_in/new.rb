# frozen_string_literal: true

class Account::Actions::SignIn::New < Account::Action
  require_signed_out_user!

  def handle(req, res)
    res.render(Account::Views::SignIn::New, values: {}, errors: {})
  end
end
