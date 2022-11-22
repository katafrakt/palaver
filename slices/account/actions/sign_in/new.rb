# frozen_string_literal: true

class Account::Actions::SignIn::New < Account::Action
  def handle(req, res)
    res.body = render(Account::Templates::SignIn::New)
  end
end
