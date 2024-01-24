# frozen_string_literal: true

module Moderation
  module Events
    class ThreadUnpinned < Dry::Struct
      include Palaver::Types

      attribute :thread_id, Integer
    end
  end
end
