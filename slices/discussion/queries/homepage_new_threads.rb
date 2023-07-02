# frozen_string_literal: true

class Discussion::Queries::HomepageNewThreads
  include Discussion::Deps[repo: "repositories.thread"]

  def call
    threads = repo.by_first_message.to_a
    counts = repo.message_counts(threads.map(&:id))
    threads.map do |thread|
      message_count = counts.detect { |c| c.thread_id == thread.id }&.count
      Discussion::Entities::Thread.from_rom(thread, message_count:)
    end
  end
end
