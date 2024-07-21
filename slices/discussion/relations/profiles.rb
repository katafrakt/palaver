# frozen_string_literal: true

module Discussion
  module Relations
    class Profiles < Palaver::DB::Relation
      schema(:profiles, infer: true)
    end
  end
end
