# frozen_string_literal: true

class Discussion::Commands::CreateProfile
  include Discussion::Deps[
    repo: "repositories.profile"
  ]

  def call(nickname:, account_id:)
    repo.create(
      nickname:, account_id:, message_count: 0
    )
  end
end