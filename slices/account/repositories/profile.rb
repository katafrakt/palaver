# frozen_string_literal: true

class Account::Repositories::Profile < Palaver::Repository[:profiles]
  commands :create, update: :by_pk

  def by_account_id(id)
    profiles.where(account_id: id).one!
  end
end
