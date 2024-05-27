module Discussion
  module Domain
    class Threads
      include Dry::Monads[:result]
      include Discussion::Events

      def start_thread(category:, title:, content:, creator:)
        ThreadCreated.new(title:, content:, creator:, category_id: category.id)
      end

      def add_reply(thread, author:, content:)
        return Failure(:thread_locked) if thread.locked?

        event = ReplyAddedToThread.new(thread_id: thread.id, author:, content:)
        Success(event)
      end
    end
  end
end
