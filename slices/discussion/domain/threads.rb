module Discussion
  module Domain
    class Threads
      include Dry::Monads[:result]
      include Discussion::Events

      def add_reply(thread, author:, content:)
        return Failure(:thread_locked) if thread.locked?

        event = ReplyAddedToThread.new(thread_id: thread.id, author:, content:)
        Success(event)
      end
    end
  end
end
