# frozen_string_literal: true

module Discussion
  module Entities
    class Thread < ROM::Struct
      include Palaver::Types

      HASHIDS_NUM = 2

      attribute :title, String
      attribute :id, Integer
      attribute? :pinned, Bool
      attribute? :messages, Array

      def self.from_rom(struct)
        new(
          id: struct.id,
          title: struct.title,
          pinned: struct.pinned,
          messages: struct.messages
        )
      end

      def resource_id = "thread:#{id}"

      def resource_type = :thread
    end
  end
end
