module Discussion
  module Repositories
    class Thread < Palaver::Repository[:threads]
      Page = Struct.new(:entries, :total_entries, :total_pages, :current_page)

      struct_namespace Discussion::Entities
      commands :create

      def set_first_message(thread:, message:)
        threads.by_pk(thread.id).changeset(:update, first_message_id: message.id).commit
      end

      def set_last_message(thread:, message:)
        threads.by_pk(thread.id).changeset(:update, last_message_id: message.id).commit
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

      def paged_messages(thread_id, page = 1)
        entries =
          messages
            .where(thread_id:)
            .combine(:author)
            .order(:posted_at)
            .per_page(15)
            .page(page)
            .to_a

        all_messages = messages.where(thread_id:).count
        Page.new(entries, all_messages, (all_messages / 15.0).ceil, page)
      end

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

      def recently_updated
        threads
          .combine(:messages)
          .left_join(:messages, id: :last_message_id)
          .order(messages[:posted_at].desc)
          .to_a
      end
    end
  end
end
