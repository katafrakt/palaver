class Discussion::Repositories::Profile < Palaver::DB::Repo[:profiles]
  def current_user(id)
    account = accounts.where(id: id).one
    return Discussion::Entities::CurrentUser.build_anonymous unless account

    profile = profiles.where(account_id: id).one
    return Discussion::Entities::CurrentUser.build_profileless(id) unless profile

    Discussion::Entities::CurrentUser.new(
      account_id: id,
      profile_id: profile.id,
      email: account.email,
      nickname: profile.nickname,
      message_count: profile.message_count || 0
    )
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
