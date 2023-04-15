# frozen_string_literal: true

class Discussion::Commands::AddMessage
  include Dry::Monads[:result]
  include Discussion::Deps[
    repo: "repositories.thread",
    profile_repo: "repositories.profile"
  ]

  def call(content:, author:, thread:)
    raise "Must be a profile entity" unless author.is_a?(Discussion::Entities::Profile)

    repo.transaction do
      author = profile_repo.get(author.id)
      message = repo.create_message(thread:, author:, content:)
      repo.sync_message_count(author)
      repo.set_last_message(thread:, message:)
      Success(message)
    end
  end
end
