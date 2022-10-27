module Discussion
  module Repositories
    class Categories < Palaver::Repository[:categories]
      commands :create

      def all
        categories.combine(:topics).to_a
      end
    end
  end
end
