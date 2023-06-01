# frozen_string_literal: true

require "stringex/unidecoder"
require "hashids"

class Discussion::Entities::Category < Dry::Struct
  include Palaver::Types

  HASHIDS_NUM = 1

  attribute :id, ID
  attribute :name, String
  attribute :thread_count, Integer
  attribute :message_count, Integer
  attribute? :latest_thread, Discussion::Entities::Thread.optional

  def self.from_rom(struct)
    attrs = {
      id: struct.id,
      name: struct.name,
      thread_count: struct.thread_count,
      message_count: struct.message_count
    }

    attrs[:latest_thread] = Discussion::Entities::Thread.from_rom(struct.latest_thread) if struct.latest_thread

    new(attrs)
  end
end
