# frozen_string_literal: true

class Discussion::Commands::UpdateProfile
  include Dry::Monads[:result]
  include Discussion::Deps[
    repo: "repositories.profile"
  ]

  def call(avatar:, account_id:)
    profile = repo.by_account_id(account_id)
    return Failure(:profile_missing) unless profile

    attacher = profile.avatar_attacher
    attacher.assign(avatar)

    params = {
      avatar_data: attacher.column_data
    }

    profile = repo.update(profile.id, params)
    attacher.finalize

    Success(profile)
  end
end
