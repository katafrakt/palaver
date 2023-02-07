class Account::Repositories::Profile < Palaver::Repository[:profiles]
  struct_namespace Account::Entities
  commands :create

  def get(id)
    profiles.by_pk(id).one!
  end

  def from_current_user(user)
    profiles.where(account_id: user.id).one
  end
end
