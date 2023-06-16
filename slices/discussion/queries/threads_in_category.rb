# frozen_string_literal: true

module Discussion
  module Queries
    class ThreadsInCategory
      include Discussion::Deps[repo: "repositories.thread"]

      def call(category_id)
        threads = repo.by_category(category_id)
        counts = repo.message_counts(threads.map(&:id))
        threads.map do |thread|
          message_count = counts.detect { |c| c.thread_id == thread.id }&.count
          Discussion::Entities::Thread.from_rom(thread, message_count:)
        end
      end
    end
  end
end
