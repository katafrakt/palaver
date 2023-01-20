# frozen_string_literal: true

module Persistence
  module Relations
    class Profiles < ROM::Relation[:sql]
      schema(:profiles, infer: true) do
        associations do
          has_many :messages, as: :author
          belongs_to :account
        end
      end
    end
  end
end
