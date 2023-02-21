# frozen_string_literal: true

class Discussion::Commands::CreateProfile
  include Discussion::Deps[
    repo: "repositories.profile"
  ]

  def call(nickname:, avatar:, account_id:)
    attacher = Discussion::Entities::Profile.avatar_attacher
    attacher.form_assign({avatar: avatar})
    attacher.finalize

    params = {
      nickname:, account_id:, message_count: 0,
      avatar_data: attacher.column_data
    }

    repo.create(params)
  end
end
