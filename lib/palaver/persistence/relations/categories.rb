# frozen_string_literal: true

module Persistence
  module Relations
    class Categories < ROM::Relation[:sql]
      schema(:categories, infer: true) do
        associations do
          has_many :threads
          belongs_to :threads, as: :latest_thread
        end
      end

      def with_counts
        left_join(:threads)
          .left_join(:messages, thread_id: :id)
          .group { `categories.id` }
          .select_append {[
            function(:count, `messages.id`).as(:message_count),
            function(:count, `threads.title`).distinct.as(:thread_count)
          ]}
      end
    end
  end
end
