# frozen_string_literal: true

module Discussion
  module Relations
    class Accounts < Palaver::DB::Relation
      schema(:accounts, infer: true)
    end
  end
end
