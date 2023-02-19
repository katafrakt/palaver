# frozen_string_literal: true

class Discussion::Commands::CreateProfile
  include Discussion::Deps[
    repo: "repositories.profile"
  ]

  def call(nickname:, avatar:, account_id:)
    Hanami.app["uploader"] # trigger provider start
    attacher = Discussion::Entities::Profile.avatar_attacher
    attacher.form_assign({avatar: avatar})
    attacher.finalize

    puts "IN CREATE"
    p avatar
    p attacher
    p attacher.column_values

    params = {
      nickname:, account_id:, message_count: 0,
      avatar_data: attacher.column_data
    }
    p params

    repo.create(params)
  end
end