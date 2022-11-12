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
        # TODO: figure out why I need to do this dance
        # ROM 6 bug?
        _schema = categories
        left_join(threads).left_join(:messages, thread_id: :id).select_append {
          threads = _schema.associations[:threads].target
          [
            integer.count(threads.associations[:messages].target[:thread_id]).as(:message_count),
            integer.count(threads[:category_id]).as(:thread_count)
          ]
        }.group(:id)
      end
    end
  end
end
