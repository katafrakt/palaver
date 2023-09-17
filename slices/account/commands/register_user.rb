require "argon2"
require "dry/monads"

class Account::Commands::RegisterUser
  include Dry::Monads[:result]
  include Account::Deps[repo: "repositories.account", hasher: "utils.hasher"]

  def call(email, password)
    confirmation_token = SecureRandom.uuid

    password_hash = hasher.create(password)
    account = repo.create(
      email: email,
      password_hash: password_hash,
      confirmation_token: confirmation_token,
      registered_at: Time.now.utc
    )
    Success(account)
  rescue ROM::SQL::UniqueConstraintError
    Failure(:email_not_unique)
  end
end
