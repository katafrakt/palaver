# frozen_string_literal: true

module Discussion
  module Operations
    class ReplyToThread < Discussion::Operation
      include Discussion::Deps[repo: "repositories.thread"]

      def call(thread:, author:, content:)
        step check_if_locked(thread)
        event = Discussion::Events::ReplyAddedToThread.new(thread_id: thread.id, author:, content:)
        repo.handle(event)
      end

      private

      def check_if_locked(thread)
        return Failure(:thread_locked) if thread.locked?
        Success()
      end
    end
  end
end
