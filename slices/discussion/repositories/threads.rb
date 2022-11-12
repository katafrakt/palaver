module Discussion
  module Repositories
    class Threads < Palaver::Repository[:threads]
      def create(title:, content:, category_id:, author_id:)
        threads.transaction do
          thread = threads.changeset(:create, title: title, category_id: category_id).commit
          message = messages.changeset(:create, text: content, author_id: author_id).associate(thread).commit
          threads.by_pk(thread.id).changeset(:update, first_message_id: message.id, last_message_id: message.id).commit
          categories.by_pk(category_id).changeset(:update, latest_thread_id: thread.id).commit
          thread
        end
      end

      def by_category(category_id)
        threads.where(category_id: category_id).combine(:latest_thread).to_a
      end

      # temp
      def create_profile(name)
        profiles.command(:create).call(nickname: name)
      end
    end
  end
end
