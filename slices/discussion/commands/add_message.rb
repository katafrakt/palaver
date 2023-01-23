# frozen_string_literal: true

class Discussion::Commands::AddMessage
  include Discussion::Deps[repo: "repositories.thread"]

  def call(content:, author:, thread:)
    repo.transaction do
      message = repo.create_message(thread:, author:, content:)
      repo.sync_message_count(author)
      repo.set_last_message(thread:, message:)
      message
    end
  end
end
