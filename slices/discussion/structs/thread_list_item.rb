# frozen_string_literal: true

module Discussion
  module Structs
    class ThreadListItem < Hanami::DB::Struct
      def locked? = !!locked

      def pinned? = !!pinned

      def replies = message_count - 1
    end
  end
end
