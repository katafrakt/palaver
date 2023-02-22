# frozen_string_literal: true

class Account::Actions::Registration::New < Account::Action
  require_signed_out_user!

  def handle(req, res)
    res.render(Account::Templates::Registration::New, values: {}, errors: {})
  end
end
