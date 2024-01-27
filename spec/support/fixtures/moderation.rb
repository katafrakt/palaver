module Fixtures
  module Moderation
    extend self

    def lock_thread(thread_id)
      event = ::Moderation::Events::ThreadLocked.new(thread_id:)
      ::Moderation::Container["repositories.thread"].handle(event)
    end
  end
end
