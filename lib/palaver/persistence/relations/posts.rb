# frozen_string_literal: true

module Persistence
  module Relations
    class Posts < ROM::Relation[:sql]
      schema(:posts, infer: true) do
        associations do
          belongs_to :topics, as: :topic
          belongs_to :profiles, as: :author
          has_many :posts
        end
      end

      def with_posts
        join(posts)
      end
    end
  end
end
