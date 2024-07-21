# frozen_string_literal: true

module Palaver
  module DB
    class Accounts < Palaver::DB::Relation
      schema(:accounts, infer: true) do
        associations do
          has_one :profiles, as: :profile
        end
      end
    end
  end
end
