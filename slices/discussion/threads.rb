class Discussion::Threads
  include Dry::Monads[:result]

  def start_thread(category:, title:, content:, creator:)
    Discussion::Events::ThreadCreated.new(title:, content:, creator:, category_id: category.id)
  end

  def add_reply(thread, author:, content:)
    return Failure(:thread_locked) if thread.locked?

    event = Discussion::Events::ReplyAddedToThread.new(thread_id: thread.id, author:, content:)
    Success(event)
  end
end
