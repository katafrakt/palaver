# frozen_string_literal: true

require "dry/monads"

class Moderation::Commands::PinThread
  include Dry::Monads[:result]
  include Moderation::Deps[
            thread_repo: "repositories.thread"
          ]

  def call(thread_id:, moderator:)
    thread_repo.pin(thread_id)
    Success()
  end
end
