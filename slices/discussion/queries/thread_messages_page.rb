# frozen_string_literal: true

class Discussion::Queries::ThreadMessagesPage
  include Discussion::Deps[repo: "repositories.thread"]

  Pager = Struct.new(:entries, :total_entries, :total_pages, :current_page)

  def call(thread_id, page_no)
    messages_per_page = ENV["DEFAULT_MESSAGES_PER_THREAD_PAGE"] || 15
    thread = repo.get(thread_id)
    thread = Discussion::Entities::Thread.new(thread.to_h)
    all_thread_messages_count = repo.message_counts([thread_id]).first.count
    entries = repo.paged_messages(thread_id, page_no.to_i)
    entries.map! { |e| Discussion::Entities::Message.from_rom(e) }
    pager = Pager.new(entries, all_thread_messages_count, (all_thread_messages_count / messages_per_page.to_f).ceil, page_no.to_i)

    {thread:, pager:}
  end
end
