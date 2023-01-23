module Discussion
  module Repositories
    class Category < Palaver::Repository[:categories]
      commands :create

      def homepage
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
