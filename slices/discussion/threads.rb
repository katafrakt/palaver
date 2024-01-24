class Discussion::Threads
  def start_thread(category:, title:, content:, creator:)
    Discussion::Events::ThreadCreated.new(title:, content:, creator:, category_id: category.id)
  end

  def add_reply(thread, author:, content:)
    Discussion::Events::ReplyAddedToThread.new(thread_id: thread.id, author:, content:)
  end
end
