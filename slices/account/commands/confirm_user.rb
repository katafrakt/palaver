class Account::Commands::ConfirmUser
  include Account::Deps[repo: "repositories.account"]
  include Dry::Monads[:result]

  def call(id, token)
    account = repo.by_id_and_token(id, token)
    return Failure(:user_not_found) unless account
    return Failure(:already_confirmed) if account.confirmed_at

    repo.confirm_user(account)
    Success()
  end
end
