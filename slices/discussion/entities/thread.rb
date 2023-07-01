# frozen_string_literal: true

module Discussion
  module Entities
    class Thread < ROM::Struct
      include Palaver::Types

      HASHIDS_NUM = 2

      attribute :title, String
      attribute :id, Integer
      attribute? :pinned, Bool
      attribute? :message_count, Integer.default(0)

      def self.from_rom(struct, message_count: 0)
        new(
          id: struct.id,
          title: struct.title,
          pinned: struct.pinned,
          message_count: message_count
        )
      end

      def resource_id = "thread:#{id}"

      def resource_type = :thread
    end
  end
end
