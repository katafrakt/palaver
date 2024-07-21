# frozen_string_literal: true

module Palaver
  module DB
    class Profiles < Palaver::DB::Relation
      schema(:profiles, infer: true) do
        associations do
          has_many :messages, as: :author
          belongs_to :account
        end
      end
    end
  end
end
