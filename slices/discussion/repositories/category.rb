module Discussion
  module Repositories
    class Category < Palaver::DB::Repo[:categories]
      commands :create

      def get(id)
        categories.by_pk(id).one!
      end

      def set_last_thread(category_id:, thread:)
        categories.by_pk(category_id).changeset(:update, last_thread_id: thread.id).commit
      end
    end
  end
end
