class Discussion::Repositories::Profile < Palaver::Repository[:profiles]
  struct_namespace Account::Entities

  def get(id)
    profiles.by_pk(id).one!
  end

  def from_current_user(user)
    profiles.where(account_id: user.id).one
  end

  def create(params)
    nickname = params.delete(:username)
    params[:nickname] = nickname
    params[:message_count] = 0
    profiles.command(:create).call(params)
  end
end
