class Account::Commands::ConfirmUser
  include Account::Deps[repo: "repositories.account"]

  def call(id, token)
    account = repo.by_id_and_token(id, token)
    repo.confirm_user(account) if account
  end
end
