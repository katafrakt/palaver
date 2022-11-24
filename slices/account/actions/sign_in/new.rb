# frozen_string_literal: true

class Account::Actions::SignIn::New < Account::Action
  def handle(req, res)
    res.render(Account::Templates::SignIn::New, values: {}, errors: {})
  end
end
