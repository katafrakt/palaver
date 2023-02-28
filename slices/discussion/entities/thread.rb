# frozen_string_literal: true

module Discussion
  module Entities
    class Thread < ROM::Struct
      def resource_id = "thread:#{id}"

      def resource_type = :thread
    end
  end
end
