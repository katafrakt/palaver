# frozen_string_literal: true

module Persistence
  module Relations
    class Messages < ROM::Relation[:sql]
      schema(:messages, infer: true) do
        associations do
          belongs_to :threads, as: :thread
          belongs_to :profiles, as: :author
        end
      end
    end
  end
end
