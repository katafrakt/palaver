require "argon2"

class Account::Commands::RegisterUser
  include Account::Deps[repo: "repositories.account"]

  def call(email, password)
    confirmation_token = SecureRandom.uuid

    crypted_password = hasher.create(password)
    account = repo.create(
      email: email,
      crypted_password: crypted_password,
      confirmation_token: confirmation_token,
      registered_at: Time.now.utc
    )
    [:ok, account]
  rescue ROM::SQL::UniqueConstraintError
    [:error, :email_not_unique]
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
