# frozen_string_literal: true

module Persistence
  module Relations
    class Topics < ROM::Relation[:sql]
      schema(:topics, infer: true) do
        associations do
          belongs_to :categories, as: :category
        end
      end
    end
  end
end
