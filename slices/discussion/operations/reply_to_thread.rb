# frozen_string_literal: true

module Discussion
  module Operations
    class ReplyToThread < Discussion::Operation
      include Discussion::Deps[repo: "repositories.thread"]

      def call(thread:, author:, content:)
        step check_if_locked(thread)
        repo.add_reply(thread:, author:, content:)
      end

      private

      def check_if_locked(thread)
        return Failure(:thread_locked) if thread.locked?
        Success()
      end
    end
  end
end
