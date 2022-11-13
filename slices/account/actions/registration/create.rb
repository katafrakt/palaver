# frozen_string_literal: true

class Account::Actions::Registration::Create < Account::Action
  contract do
    schema do
      required(:email).filled(:str?)
      required(:password).filled(:str?, min_size?: 8)
      required(:password_confirmation).filled(:str?, min_size?: 8)
    end

    rule(:password_confirmation, :password) do
      key.failure("passwords do not match") if values[:password] != values[:password_confirmation]
    end
  end

  def handle(req, res)
    if req.params.valid?
      res.body = "ok"
    else
      res.status = 422
      res.body = render(Account::Templates::Registration::New, values: req.params.to_h, errors: req.params.errors)
    end
  end
end
