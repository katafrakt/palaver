# frozen_string_literal: true

module Discussion
  module Operations
    class ReplyToThread < Discussion::Operation
      include Discussion::Deps[repo: "repositories.thread"]
      include Discussion::Events

      def call(thread:, author:, content:)
        step check_if_locked(thread)

        message = repo.add_reply(thread:, author:, content:)
        ReplyAddedToThread.new(
          thread_id: thread.id,
          author:,
          content:,
          message:
        )
      end

      private

      def check_if_locked(thread)
        return Failure(:thread_locked) if thread.locked?
        Success()
      end
    end
  end
end
