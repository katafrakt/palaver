# frozen_string_literal: true

module Discussion
  module Queries
    class Homepage
      Thread = Data.define(:id, :title, :message_count, :pinned, :locked)
      Category = Data.define(:id, :name, :thread_count, :message_count, :latest_thread)

      include Discussion::Deps["relations.threads", "relations.categories"]

      def category_list
        categories
          .left_join(:threads, {category_id: :id})
          .left_join(:messages, {thread_id: :id})
          .select_append {
          [
            integer.count(Sequel[:threads][:id]).as(:thread_count),
            integer.count(Sequel[:messages][:id]).as(:message_count)
          ]
        }
          .group(categories[:id])
          .order(categories[:id].asc)
          .to_a
          .map { to_category(it) }
      end

      def recent_threads
        threads
          .left_join(:messages, {id: :last_message_id}, table_alias: :last_messages)
          .with_message_counts
          .group(threads[:id], Sequel[:last_messages][:posted_at])
          .order(Sequel[:last_messages][:posted_at].desc)
          .to_a
          .map { to_thread(it) }
      end

      def new_threads
        threads
          .left_join(:messages, {id: :first_message_id}, table_alias: :first_messages)
          .with_message_counts
          .group(threads[:id], Sequel[:first_messages][:posted_at])
          .order(Sequel[:first_messages][:posted_at].desc)
          .to_a
          .map { to_thread(it) }
      end

      private def to_thread(relation)
        Thread.new(
          id: relation[:id],
          title: relation[:title],
          message_count: relation[:message_count],
          pinned: relation[:pinned],
          locked: relation[:locked]
        )
      end

      private def to_category(relation)
        Category.new(
          id: relation[:id],
          name: relation[:name],
          thread_count: relation[:thread_count],
          message_count: relation[:message_count],
          latest_thread: nil
        )
      end
    end
  end
end
