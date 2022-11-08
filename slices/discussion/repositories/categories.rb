module Discussion
  module Repositories
    class Categories < Palaver::Repository[:categories]
      commands :create

      def all
        categories.combine(:topics).to_a
      end

      def get(id)
        categories.by_pk(id).one!
      end
    end
  end
end
