# frozen_string_literal: true

require "dry/monads"

class Account::Commands::ChangePassword
  include Dry::Monads[:result]
  include Account::Deps[repo: "repositories.account", hasher: "utils.hasher"]

  def call(user_id, password)
    password_hash = hasher.create(password)
    account = repo.update(user_id, password_hash:)
    Success(account)
  end
end
