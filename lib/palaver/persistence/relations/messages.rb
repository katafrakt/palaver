# frozen_string_literal: true

module Persistence
  module Relations
    class Messages < ROM::Relation[:sql]
      schema(:messages, infer: true) do
        associations do
          belongs_to :threads, as: :thread
          belongs_to :profiles, as: :author
        end
      end

      def paged_for_thread(thread_id:, page:, per_page:)
        where(thread_id:)
          .combine(:author)
          .order(:posted_at)
          .per_page(per_page)
          .page(page)
      end
    end
  end
end
