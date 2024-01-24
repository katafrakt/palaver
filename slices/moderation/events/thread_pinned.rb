# frozen_string_literal: true

module Moderation
  module Events
    class ThreadPinned < Dry::Struct
      include Palaver::Types

      attribute :thread_id, Integer
    end
  end
end
