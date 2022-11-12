# frozen_string_literal: true

module Persistence
  module Relations
    class Threads < ROM::Relation[:sql]
      schema(:threads, infer: true) do
        associations do
          belongs_to :categories, as: :category
          has_many :messages
          has_one :categories, as: :latest_thread
          belongs_to :messages, as: :last_message
        end
      end

      def with_messages
        left_join(messages)
      end
    end
  end
end
