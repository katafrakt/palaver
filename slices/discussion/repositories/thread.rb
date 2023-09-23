module Discussion
  module Repositories
    class Thread < Palaver::Repository[:threads]
      commands :create

      def set_first_message(thread:, message:)
        threads.by_pk(thread.id).changeset(:update, first_message_id: message.id).commit
      end

      def set_last_message(thread:, message:)
        threads.by_pk(thread.id).changeset(:update, last_message_id: message.id).commit
      end

      def by_category(category_id)
        threads.where(category_id:)
          .combine(:last_message)
          .order([Sequel.case({pinned: 0}, 1)])
          .to_a
      end

      def message_counts(thread_ids)
        messages
          .where(thread_id: thread_ids)
          .group(:thread_id)
          .select { [thread_id, integer.count(id).as(:count)] }
          .order(:thread_id)
          .to_a
      end

      # temp
      def create_profile(name)
        profiles.command(:create).call(nickname: name, message_count: 0)
      end

      def get(id)
        threads.by_pk(id).one!
      end

      def paged_messages(thread_id, page = 1)
        messages
          .where(thread_id:)
          .combine(:author)
          .order(:posted_at)
          .per_page(15)
          .page(page)
          .to_a
      end

      def create_message(thread:, author:, content:)
        messages
          .changeset(:create, text: content, posted_at: DateTime.now, author_id: author.id)
          .associate(thread)
          .commit
      end

      def sync_message_count(author)
        count = messages.where(author_id: author.id).count
        profiles.by_pk(author.id).changeset(:update, message_count: count).commit
      end

      def by_first_message
        threads
          .left_join(:messages, id: :first_message_id)
          .combine(:messages).order(messages[:posted_at].desc)
      end

      def by_last_message
        threads
          .combine(:messages)
          .left_join(:messages, id: :last_message_id)
          .order(messages[:posted_at].desc)
      end
    end
  end
end
