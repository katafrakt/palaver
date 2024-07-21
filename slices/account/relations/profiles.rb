# frozen_string_literal: true

module Account
  module Relations
    class Profiles < Palaver::DB::Relation
      schema(:profiles, infer: true) do
        associations do
          belongs_to :account
        end
      end
    end
  end
end
