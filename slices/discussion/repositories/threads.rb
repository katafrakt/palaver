module Discussion
  module Repositories
    class Threads < Palaver::Repository[:threads]
      def create(title:, content:, category_id:, author:)
        threads.transaction do
          thread = threads.changeset(:create, title: title, category_id: category_id).commit
          message = create_message(thread: thread, author: author, content: content)
          sync_message_count(author)
          threads.by_pk(thread.id).changeset(:update, first_message_id: message.id, last_message_id: message.id).commit
          categories.by_pk(category_id).changeset(:update, latest_thread_id: thread.id).commit
          thread
        end
      end

      def by_category(category_id)
        threads.where(category_id: category_id).combine(:last_message).combine(:messages).to_a
      end

      # temp
      def create_profile(name)
        profiles.command(:create).call(nickname: name, message_count: 0)
      end

      def get(id)
        threads.by_pk(id).one!
      end

      def paged_messages(thread_id, _page)
        messages.where(thread_id: thread_id).combine(:author).order(:posted_at).to_a
      end

      def create_reply(thread:, author:, content:)
        messages.transaction do
          create_message(thread: thread, author: author, content: content)
          sync_message_count(author)
        end
      end

      private

      def create_message(thread:, author:, content:)
        messages
          .changeset(:create, text: content, posted_at: DateTime.now)
          .associate(thread)
          .associate(author)
          .commit
      end

      def sync_message_count(author)
        count = messages.where(author_id: author.id).count
        profiles.by_pk(author.id).changeset(:update, message_count: count).commit
      end
    end
  end
end
