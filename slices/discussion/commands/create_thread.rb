# frozen_string_literal: true

require "dry/monads"

class Discussion::Commands::CreateThread
  include Dry::Monads[:result]
  include Discussion::Deps[
    repo: "repositories.thread",
    add_message: "commands.add_message",
    category_repo: "repositories.category"
  ]

  def call(title:, content:, category_id:, author:)
    repo.transaction do
      thread = repo.create(title:, category_id:, author:)
      message = add_message.call(thread:, content:, author:).value!
      repo.set_first_message(thread:, message:)
      category_repo.set_last_thread(category_id:, thread:)
      Success(thread)
    end
  end
end
