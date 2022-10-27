module Discussion
  module Repositories
    class Topics < Palaver::Repository[:topics]
      commands :create

      def all
        categories.to_a
      end
    end
  end
end
