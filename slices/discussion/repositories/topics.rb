module Discussion
  module Repositories
    class Topics < Palaver::Repository[:topics]
      def create(title:, content:, category_id:, author_id:)
        topics.transaction do
          topic = topics.changeset(:create, title: title, category_id: category_id).commit
          post = posts.changeset(:create, text: content, author_id: author_id).associate(topic).commit
          topics.by_pk(topic.id).changeset(:update, first_post_id: post.id, last_post_id: post.id).commit
          categories.by_pk(category_id).changeset(:update, latest_topic_id: topic.id).commit
          topic
        end
      end

      def by_category(category_id)
        topics.where(category_id: category_id).combine(:latest_topic).to_a
      end

      # temp
      def create_profile(name)
        profiles.command(:create).call(nickname: name)
      end
    end
  end
end
