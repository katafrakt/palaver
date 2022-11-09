# frozen_string_literal: true

module Persistence
  module Relations
    class Categories < ROM::Relation[:sql]
      schema(:categories, infer: true) do
        associations do
          has_many :topics
          belongs_to :topics, as: :latest_topic
        end
      end

      def with_counts
        # TODO: figure out why I need to do this dance
        # ROM 6 bug?
        _schema = categories
        left_join(topics).left_join(:posts, topic_id: :id).select_append {
          topics = _schema.associations[:topics].target
          [
            integer::count(topics.associations[:posts].target[:topic_id]).as(:post_count),
            integer::count(topics[:category_id]).as(:topic_count)
          ]
        }.group(:id)
      end
    end
  end
end
