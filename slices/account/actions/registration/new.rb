# frozen_string_literal: true

class Account::Actions::Registration::New < Account::Action
  require_signed_out_user!

  def handle(_req, res)
    res[:values] = {}
    res[:errors] = {}
  end
end
