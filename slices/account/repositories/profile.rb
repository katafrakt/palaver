# frozen_string_literal: true

class Account::Repositories::Profile < Palaver::DB::Repo[:profiles]
  commands :create, update: :by_pk

  def by_account_id(id)
    data = profiles.where(account_id: id).one
    data ? to_entity(data) : nil
  end

  private

  def to_entity(data)
    Account::Entities::Profile.new(
      id: data.id,
      nickname: data.nickname,
      avatar_data: data.avatar_data
    )
  end
end
