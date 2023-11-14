# frozen_string_literal: true

module Discussion
  module Entities
    class Thread < ROM::Struct
      include Palaver::Types

      HASHIDS_NUM = 2

      attribute :title, String
      attribute :id, Integer
      attribute? :pinned, Bool.default(false)
      attribute? :message_count, Integer.default(0)
      attribute? :creator, Discussion::Entities::Author

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

      def add_reply(author:, content:)
        Discussion::Events::ReplyAddedToThread.new(thread_id: id, author:, content:)
      end
    end
  end
end
