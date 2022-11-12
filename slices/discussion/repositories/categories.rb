module Discussion
  module Repositories
    class Categories < Palaver::Repository[:categories]
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
    end
  end
end
