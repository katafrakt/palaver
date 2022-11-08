# frozen_string_literal: true

module Persistence
  module Relations
    class Posts < ROM::Relation[:sql]
      schema(:posts, infer: true) do
        associations do
          belongs_to :topics, as: :topic
        end
      end
    end
  end
end
