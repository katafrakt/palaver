# frozen_string_literal: true

module Discussion
  module Relations
    class Threads < Palaver::DB::Relation
      schema(:threads, infer: true) do
        associations do
          belongs_to :categories, as: :category
          has_many :messages
          has_one :categories, as: :latest_thread
          belongs_to :messages, as: :last_message
        end
      end

      use :pagination
    end
  end
end
