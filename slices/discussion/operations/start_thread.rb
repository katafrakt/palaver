# frozen_string_literal: true

module Discussion
  module Operations
    class StartThread < Discussion::Operation
      include Discussion::Deps[repo: "repositories.thread"]

      def call(category:, title:, content:, creator:)
        event = Discussion::Events::ThreadCreated.new(title:, content:, creator:, category_id: category.id)
        repo.handle(event)
      end
    end
  end
end
