class Account::Repositories::Account < Palaver::Repository[:accounts]
  commands :create

  def by_id_and_token(id, token)
    accounts.where(id: id, confirmation_token: token).one
  end

  def confirm_user(account)
    account.changeset(:update, confirmed_at: Time.now.utc).commit
  end
end
