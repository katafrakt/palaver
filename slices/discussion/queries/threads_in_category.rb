# frozen_string_literal: true

module Discussion
  module Queries
    class ThreadsInCategory
      include Discussion::Deps[repo: "repositories.thread"]

      def call(category_id)
        repo.by_category(category_id).map do |thread|
          Discussion::Entities::Thread.from_rom(thread)
        end
      end
    end
  end
end
