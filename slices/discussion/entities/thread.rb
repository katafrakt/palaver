# frozen_string_literal: true

module Discussion
  module Entities
    class Thread < ROM::Struct
      include Palaver::Types

      attribute :title, String
      attribute :id, Integer

      def self.from_rom(struct)
        new(
          title: struct.title
        )
      end

      def resource_id = "thread:#{id}"

      def resource_type = :thread
    end
  end
end
