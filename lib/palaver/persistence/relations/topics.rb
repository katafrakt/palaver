# frozen_string_literal: true

module Persistence
  module Relations
    class Topics < ROM::Relation[:sql]
      schema(:topics, infer: true) do
        associations do
          belongs_to :categories, as: :category
          has_many :posts
          has_one :categories, as: :latest_topic
        end
      end

      def with_posts
        left_join(posts)
      end
    end
  end
end
