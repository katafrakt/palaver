# frozen_string_literal: true

class Account::Actions::Registration::New < Account::Action
  def handle(req, res)
    res.body = render(Account::Templates::Registration::New)
  end
end
