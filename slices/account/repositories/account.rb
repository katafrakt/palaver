class Account::Repositories::Account < Palaver::Repository[:accounts]
  struct_namespace Account::Entities
  auto_struct true
  commands :create

  def by_id_and_token(id, token)
    accounts.where(id: id, confirmation_token: token).one
  end

  def confirm_user(account)
    accounts.by_pk(account.id).changeset(:update, confirmed_at: Time.now.utc).commit
  end

  def get_by_email(email)
    accounts.where(email: email).one
  end

  def by_session_id(id)
    accounts.by_pk(id).map_to(Account::Entities::CurrentUser).one || Account::Entities::AnonymousUser.new
  end

  def settings_for_user(id)
    accounts.by_pk(id).combine(:profile).one
  end
end
