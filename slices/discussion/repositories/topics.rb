module Discussion
  module Repositories
    class Topics < Palaver::Repository[:topics]
      def create(title:, content:, category_id:)
        topics.transaction do
          topic = topics.changeset(:create, title: title, category_id: category_id).commit
          posts.changeset(:create, text: content).associate(topic).commit
          topic
        end
      end

      def by_category(category_id)
        topics.where(category_id: category_id).to_a
      end
    end
  end
end
