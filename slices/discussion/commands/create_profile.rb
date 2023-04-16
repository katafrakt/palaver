# frozen_string_literal: true

class Discussion::Commands::CreateProfile
  include Dry::Monads[:result]
  include Discussion::Deps[
    repo: "repositories.profile"
  ]

  def call(nickname:, account_id:, avatar: nil)
    attacher = Discussion::Entities::Profile.avatar_attacher
    attacher.form_assign({avatar:})
    attacher.finalize

    params = {
      nickname:, account_id:, message_count: 0,
      avatar_data: attacher.column_data
    }

    profile = repo.create(params)
    Success(profile)
  end
end
