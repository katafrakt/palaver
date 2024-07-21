# frozen_string_literal: true

module Moderation
  module Relations
    class Threads < Palaver::DB::Relation
      schema(:threads, infer: true) do
        associations do
          belongs_to :category
        end
      end
    end
  end
end
