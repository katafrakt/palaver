# frozen_string_literal: true

module Discussion
  module Operations
    class StartThread < Discussion::Operation
      include Deps[repo: "repositories.thread", category_repo: "repositories.category"]

      class Decider
        ThreadCreated = Discussion::Events::ThreadCreated

        def self.decide(title:, content:, creator:, category:)
          ThreadCreated.new(title:, content:, creator:, category_id: category.id)
        end
      end
      
      def call(category_id:, title:, content:, creator:)
        category = step get_category(category_id)
        event = Decider.decide(title:, content:, creator:, category:)
        step persist(event)
      end

      private

      def get_category(id)
        Success(category_repo.get(id))
      rescue ROM::TupleCountMismatchError
        Failure(:category_not_found)
      end

      def persist(event)
        if thread = repo.handle(event)
          Success(thread)
        else
          Failure(:persistence_error)
        end
      end
    end
  end
end
