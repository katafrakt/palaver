# frozen_string_literal: true

require "dry/monads"

class Account::Commands::SetAvatar
  include Dry::Monads[:result]
  include Account::Deps[repo: "repositories.profile"]

  def call(user_id, avatar)
    attacher = Account::Entities::Settings.avatar_attacher
    attacher.assign(avatar)
    attacher.finalize

    params = {avatar_data: attacher.column_data}
    profile = repo.by_account_id(user_id)
    profile = repo.update(profile.id, params)
    Success(profile)
  end
end
