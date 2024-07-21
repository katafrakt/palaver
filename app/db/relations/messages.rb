# frozen_string_literal: true

module Palaver
  module DB
    class Messages < Palaver::DB::Relation
      schema(:messages, infer: true) do
        associations do
          belongs_to :threads, as: :thread
          belongs_to :profiles, as: :author
        end
      end
    end
  end
end
