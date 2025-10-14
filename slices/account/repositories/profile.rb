# frozen_string_literal: true

class Account::Repositories::Profile < Palaver::DB::Repo[:profiles]
  commands :create, update: :by_pk

  def by_account_id(id)
    profiles.where(account_id: id).one.then(&method(:to_entity))
  end

  private

  def to_entity(data)
    Account::Entities::Profile.new(
      id: data.id,
      avatar_data: data.avatar_data
    )
  end
end
