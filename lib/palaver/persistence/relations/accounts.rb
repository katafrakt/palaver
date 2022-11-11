# frozen_string_literal: true

module Persistence
  module Relations
    class Accounts < ROM::Relation[:sql]
      schema(:accounts, infer: true) do
        associations do
          has_one :profiles, as: :profile
        end
      end
    end
  end
end
