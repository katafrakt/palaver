class Discussion::Repositories::Profile < Palaver::Repository[:profiles]
  struct_namespace Discussion::Entities

  def get(id)
    profiles.by_pk(id).one!
  end

  def by_account_id(id) = profiles.where(account_id: id).one

  def from_current_user(user)
    profiles.where(account_id: user.id).one
  end

  def create(params)
    params[:message_count] = 0
    profiles.command(:create).call(params)
  end

  def update(id, params)
    command = profiles.by_pk(id).command(:update)
    command.call(params)
  end
end
