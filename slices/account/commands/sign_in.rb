# frozen_string_literal: true

require "argon2"

class Account::Commands::SignIn
  include Account::Deps[repo: "repositories.account"]

  def call(email, password)
    account = repo.get_by_email(email)

    if account.nil?
      [:error, :not_found]
    elsif account.confirmed_at.nil?
      [:error, :not_confirmed]
    elsif !Argon2::Password.verify_password(password, account.crypted_password)
      [:error, :incorrect_password]
    else
      [:ok, account]
    end
  end
end
