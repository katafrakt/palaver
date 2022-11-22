# frozen_string_literal: true

class Account::Commands::SignIn
  include Account::Deps[repo: "repositories.account"]

  def call(email, password)
    crypted_password = hasher.create(password)
    account = repo.get_by_email_and_password(email, crypted_password)

    if account.nil?
      [:error, :not_found]
    elsif account.confirmed_at.nil?
      [:error, :not_confirmed]
    else
      [:ok, account]
    end
  end

  private

  # :nocov:
  def hasher
    if Hanami.env == :test
      Argon2::Password.new(t_cost: 1, m_cost: 4, p_cost: 1)
    else
      Argon2::Password.new
    end
  end
  # :nocov:
end
