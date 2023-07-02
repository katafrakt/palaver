# frozen_string_literal: true

require "hashids"

module Discussion
  module Utils
    class ThreadIndexer
      def call(pager, message)
        offset = (pager.current_page - 1) * pager.per_page
        offset + (pager.entries.index { _1.id == message.id } + 1)
      end
    end
  end
end
