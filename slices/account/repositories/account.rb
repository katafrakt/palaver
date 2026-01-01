class Account::Repositories::Account < Palaver::DB::Repo[:accounts]
  struct_namespace Account::Entities
  auto_struct true
  commands :create, update: :by_pk

  def by_id(id)
    accounts.where(id:).one!
  end

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

  def settings_by_user_id(id)
    accounts.by_pk(id).combine(:profile).one
      .then { Account::Entities::Settings.from_rom(it) }
  end
end
