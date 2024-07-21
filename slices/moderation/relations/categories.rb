# frozen_string_literal: true

module Moderation
  module Relations
    class Categories < Palaver::DB::Relation
      schema(:categories, infer: true) do
        associations do
          has_many :threads
        end
      end
    end
  end
end
