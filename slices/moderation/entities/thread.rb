# frozen_string_literal: true

module Moderation
  module Entities
    class Thread < Dry::Struct
      include Palaver::Types

      attribute :id, Integer
      attribute :pinned, Bool

      def pinned? = pinned
    end
  end
end
