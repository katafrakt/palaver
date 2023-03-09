# frozen_string_literal: true

require "argon2"

class Account::Commands::SignIn
  include Dry::Monads[:result]
  include Account::Deps[repo: "repositories.account"]

  def call(email, password)
    account = repo.get_by_email(email)

    if account.nil?
      Failure(:not_found)
    elsif account.confirmed_at.nil?
      Failure(:not_confirmed)
    elsif !Argon2::Password.verify_password(password, account.password_hash)
      Failure(:incorrect_password)
    else
      Success(account)
    end
  end
end
