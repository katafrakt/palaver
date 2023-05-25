# frozen_string_literal: true

class Discussion::Entities::Category < Dry::Struct
  include Palaver::Types

  attribute :id, ID
  attribute :name, String
  attribute :thread_count, Integer
  attribute :message_count, Integer
  attribute? :latest_thread, Discussion::Entities::Thread.optional

  def self.from_rom(struct)
    new(
      id: struct.id,
      name: struct.name,
      thread_count: struct.thread_count,
      message_count: struct.message_count
    )
  end

  def set_latest_thread(thread)
    attrs = self.attributes.merge(latest_thread: thread)
    self.class.new(attrs)
  end
end
