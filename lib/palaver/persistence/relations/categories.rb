# frozen_string_literal: true

module Persistence
  module Relations
    class Categories < ROM::Relation[:sql]
      schema(:categories, infer: true) do
        associations do
          has_many :topics
        end
      end
    end
  end
end