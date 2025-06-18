# frozen_string_literal: true

module Discussion
  module Operations
    class StartThread < Discussion::Operation
      include Discussion::Deps[repo: "repositories.thread"]

      def call(category:, title:, content:, creator:)
        repo.create(category:, title:, content:, creator:)
      end
    end
  end
end
