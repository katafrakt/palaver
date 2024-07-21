module Discussion
  module Repositories
    class Category < Palaver::DB::Repo[:categories]
      commands :create

      def all_with_last_thread
        categories
          .with_counts
          .combine(latest_thread: {last_message: :author})
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
