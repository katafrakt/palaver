class Discussion::Repositories::Profile < Palaver::Repository[:profiles]
  def get(id)
    record = profiles.by_pk(id).one!
    ::Discussion::Entities::Profile.new(id: record.id, nickname: record.nickname, account_id: record.account_id, message_count: record.message_count)
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
