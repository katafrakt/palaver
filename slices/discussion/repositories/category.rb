module Discussion
  module Repositories
    class Category < Palaver::DB::Repo[:categories]
      commands :create

      def list
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
          .as(:category_list_item)
          .to_a
      end

      def get(id)
        categories.by_pk(id).one!
      end

      def set_last_thread(category_id:, thread:)
        categories.by_pk(category_id).changeset(:update, last_thread_id: thread.id).commit
      end
    end
  end
end
