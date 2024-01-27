# frozen_string_literal: true

module Moderation
  module Entities
    class Thread < Dry::Struct
      include Palaver::Types

      attribute :id, Integer
      attribute :pinned, Bool
      attribute :locked, Bool

      def pinned? = pinned

      def locked? = locked
    end
  end
end
