# frozen_string_literal: true

require "dry/monads"

class Moderation::Threads
  include Moderation::Events
  include Dry::Monads[:result]

  def pin(thread)
    return Failure(:thread_already_pinned) if thread.pinned?

    event = ThreadPinned.new(thread_id: thread.id)
    Success(event)
  end

  def unpin(thread)
    return Failure(:thread_not_pinned) unless thread.pinned?

    event = ThreadUnpinned.new(thread_id: thread.id)
    Success(event)
  end

  def lock(thread)
    return Failure(:thread_already_locked) if thread.locked?
    event = ThreadLocked.new(thread_id: thread.id)
    Success(event)
  end

  def unlock(thread)
    return Failure(:thread_not_locked) unless thread.locked?
    event = ThreadUnlocked.new(thread_id: thread.id)
    Success(event)
  end
end
